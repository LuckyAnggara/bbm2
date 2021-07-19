<template>
  <div ref="formContainer">
    <form-wizard
      color="#7367F0"
      :start-index="startIndex"
      :title="null"
      :subtitle="null"
      layout="vertical"
      finish-button-text="Proses"
      custom-buttons-right="assd"
      back-button-text="Previous"
      class="wizard-vertical mb-3"
      @on-complete="formSubmitted"
    >
      <!-- account datails tab -->
      <tab-content title="Data Kontak" :before-change="beforeTabSwitch1">
        <detail-supplier :data-order="dataOrder" />
      </tab-content>

      <!-- personal info tab -->
      <tab-content title="Keranjang" :before-change="beforeTabSwitch2">
        <keranjang :data-order="dataOrder" />
      </tab-content>
      <!-- social link -->
      <tab-content title="Review Order">
        <review-order :data-order="dataOrder" />
      </tab-content>
    </form-wizard>
    <!-- <b-modal
      id="modal-prevent-closing"
      ref="my-modal"
      title="Pembayaran"
      ok-title="Proses"
      cancel-variant="outline-secondary"
      @show="resetModal"
      @hidden="resetModal"
      @ok="store"
    >
      <b-card-body>
        <section>
          <b-row>
            <b-col cosl="12" md="12">
              <b-form-group label="Uang diterima" label-for="jumlah-pembayaran" label-cols-md="5">
                <b-form-input id="jumlah-pembayaran" v-model="jumlahPembayaran" placeholder="Jumlah Uang yang diterima" type="number" />
              </b-form-group>
            </b-col>
          </b-row>
          <b-row>
            <b-col cols="12" md="12">
              <b-form-group label="Kembalian" label-for="kembalian" label-cols-md="5">
                <b-form-input id="kembalian" v-model="kembalian" readonly type="text" />
              </b-form-group>
              <hr />
            </b-col>
          </b-row>
        </section>
      </b-card-body>
    </b-modal> -->
  </div>
</template>

<script>
import { ref } from '@vue/composition-api'
import { FormWizard, TabContent } from 'vue-form-wizard'
import 'vue-form-wizard/dist/vue-form-wizard.min.css'
import router from '@/router'
import store from '@/store'

import DetailSupplier from './component/DetailSupplier.vue'
import ReviewOrder from './component/ReviewOrder.vue'
import Keranjang from './component/Keranjang.vue'

export default {
  components: {
    FormWizard,
    DetailSupplier,
    ReviewOrder,
    TabContent,
    Keranjang,
  },
  data() {
    return {
      jumlahPembayaran: 0,
      startIndex: 0,
    }
  },
  mounted() {
    this.load()
  },
  methods: {
    success() {
      this.$swal({
        title: 'Success!',
        text: 'Transaksi Sukses!!',
        icon: 'success',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })

      this.$router.push({
        name: 'transaksi-pembelian-daftar',
      })
    },
    error(error) {
      this.$swal({
        title: 'Error!',
        text: `Oopss ada Masalah!${error}`,
        icon: 'error',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
    },
    errorNomor() {
      this.$swal({
        title: 'Error!',
        text: 'Nomor transaksi masih kosong!!!',
        icon: 'error',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
    },
    errorTanggal() {
      this.$swal({
        title: 'Error!',
        text: 'Tanggal transaksi masih kosong!!!',
        icon: 'error',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
    },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
    beforeTabSwitch1() {
      if (this.dataOrder.supplier.nama !== '' || this.dataOrder.supplier.alamat !== '') {
        if (this.dataOrder.nomor === '') {
          this.dataOrder.nomor = parseFloat(store.getters['app-transaksi-pembelian/getJumlahPembelian']) + parseFloat(1)
        }
        return true
      }
      this.$swal({
        icon: 'error',
        title: 'Oopss Data Pelanggan Masih Kosong',
        customClass: {
          confirmButton: 'btn btn-success',
        },
      })
      return false
    },
    beforeTabSwitch2() {
      if (this.dataOrder.orders.length > 0) {
        return true
      }
      this.$swal({
        icon: 'error',
        title: 'Oopss Data Order Masih Kosong',
        customClass: {
          confirmButton: 'btn btn-danger',
        },
      })
      return false
    },
    formSubmitted() {
      this.store()
    },
    resetModal() {
      this.jumlahPembayaran = 0
    },
    showModal() {
      this.$refs['my-modal'].show()
    },
    store() {
      if (this.dataOrder.nomorTransaksi === '' || this.dataOrder.nomorTransaksi === null) {
        this.errorNomor()
      } else if (this.dataOrder.tanggalTransaksi === '' || this.dataOrder.tanggalTransaksi === null) {
        this.errorTanggal()
      } else {
        const loader = this.$loading.show({
          // Optional parameters
          container: this.$refs.formContainer,
        })
        store
          .dispatch('app-transaksi-pembelian/addTransaksi', this.dataOrder)
          .then(res => {
            if (res.status === 200) {
              loader.hide()
              this.dataOrder.nomorTransaksi = res.data.nomor_transaksi
              this.dataOrder.tanggalTransaksi = res.data.created_at
              store.commit('app-transaksi-pembelian/SET_DATA_INVOICE', this.dataOrder)
              if (router.currentRoute.params.nomor !== undefined) {
                store.commit('app-transaksi-pembelian/REMOVE_DRAFT_PEMBELIAN', router.currentRoute.params.nomor)
              }
              this.success()
            } else {
              this.error()
            }
          })
          .catch(error => {
            this.error(error)
          })
      }
    },
    load() {
      if (router.currentRoute.params.id !== undefined) {
        this.dataOrder = store.getters['app-transaksi-pembelian/getDraftByID'](router.currentRoute.params.id)
        this.startIndex = 1
      }
    },
  },
  setup() {
    const dataOrder = ref({
      catatan: '',
      startIndex: 0,
      nomorTransaksi: '',
      tanggalTransaksi: '',
      nomor: 0,
      status: false, // untuk Status Draft atau Proses
      supplier: {
        id: '',
        nama: '',
        alamat: '',
        nomorTelepon: '',
      },
      invoice: {
        total: 0,
        diskon: 0,
        pajak: 0,
        ongkir: 0,
        grandTotal: 0,
      },
      pembayaran: {
        bank: '',
        jenisPembayaran: { title: 'Tunai', value: '0' },
        kredit: false,
        downPayment: 0,
        tanggalJatuhTempo: '',
        statusPembayaran: { title: 'Lunas', value: '0' },
      },
      orders: [],
      user: JSON.parse(localStorage.getItem('userData')),
    })
    return {
      dataOrder,
    }
  },
}
</script>

<style lang="scss">
@import '@core/scss/vue/libs/vue-wizard.scss';
@import '@core/scss/vue/libs/vue-select.scss';
@import '@core/scss/vue/libs/vue-select.scss';
.add-new-data-header {
  padding: $options-padding-y $options-padding-x;
  color: $success;

  &:hover {
    background-color: rgba($success, 0.12);
  }
}
</style>
