<template>
  <div ref="formContainer">
    <form-wizard
      color="#7367F0"
      :start-index="startIndex"
      :title="null"
      :subtitle="null"
      layout="vertical"
      finish-button-text="Edit Transaksi"
      custom-buttons-right="assd"
      back-button-text="Previous"
      class="wizard-vertical mb-3"
      @on-complete="formSubmitted"
    >
      <!-- account datails tab -->
      <tab-content title="Data Kontak" :before-change="beforeTabSwitch1">
        <detail-konsumen :data-order="dataOrder" />
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
  </div>
</template>

<script>
import { ref } from '@vue/composition-api'
import { FormWizard, TabContent } from 'vue-form-wizard'
// import vSelect from 'vue-select'
import 'vue-form-wizard/dist/vue-form-wizard.min.css'
import router from '@/router'
import store from '@/store'

import DetailKonsumen from './component/DetailKonsumen.vue'
import ReviewOrder from './component/ReviewOrder.vue'
import Keranjang from './component/Keranjang.vue'

export default {
  components: {
    FormWizard,
    DetailKonsumen,
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
  computed: {
    kembalian() {
      if (this.jumlahPembayaran === 0) {
        return this.formatRupiah(0)
      }
      return this.formatRupiah(this.jumlahPembayaran - this.dataOrder.invoice.grandTotal)
    },
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
        name: 'transaksi-penjualan-invoice',
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
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
    beforeTabSwitch1() {
      if (this.dataOrder.pelanggan.nama !== '' || this.dataOrder.pelanggan.alamat !== '') {
        if (this.dataOrder.nomor === '') {
          this.dataOrder.nomor = parseFloat(store.getters['app-transaksi-penjualan/getJumlahPenjualan']) + parseFloat(1)
        }
        // store.commit('app-transaksi-penjualan/SET_ACTIVE_PENJUALAN', this.dataOrder)
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
      this.$swal({
        title: 'Retur data ?',
        text: 'Data transaksi penjualan akan di retur',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Ya!',
        customClass: {
          confirmButton: 'btn btn-primary',
          cancelButton: 'btn btn-outline-danger ml-1',
        },
        buttonsStyling: false,
      }).then(result => {
        if (result.value) {
          this.store()
        }
      })
    },
    store() {
      const loader = this.$loading.show({
        // Optional parameters
        container: this.$refs.formContainer,
      })
      store
        .dispatch('app-transaksi-penjualan/editTransaksi', this.dataOrder)
        .then(res => {
          loader.hide()
          if (res.status === 200) {
            console.info(res)
            this.success()
          } else {
            console.info(res)

            this.error()
          }
        })
        .catch(error => {
          this.error(error)
        })
    },
    load() {
      const { id } = router.currentRoute.params
      this.dataOrder = store.getters['app-transaksi-penjualan/getListTransaksiPenjualan'].find(x => x.id === id)
      console.info(this.dataOrder)
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
      sales: {
        id: '',
        nama: '',
      }, // untuk Status Draft atau Proses
      pelanggan: {
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
