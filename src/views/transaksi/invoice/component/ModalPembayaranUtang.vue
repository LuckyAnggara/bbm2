<template>
  <b-modal centered size="lg" id="modal-pembayaran-utang" title="Pembayaran Utang" ok-title="Proses" cancel-variant="outline-secondary" @ok="store" lazy>
    <!-- <b-modal id="modal-default" ref="my-modal" ok-only ok-title="Submit" centered :title="detailBarang.nama"> -->
    <section>
      <b-row>
        <b-col cols="12" md="12" class="mb-2">
          <p class="text-muted">
            Sisa utang Nomor Transaksi {{ dataUtang.nomorTransaksi }} : <b>{{ formatRupiah(dataUtang.pembayaran.sisaPembayaran) }}</b>
          </p>
        </b-col>
        <b-col cols="12" md="12">
          <b-form-group label="Tanggal Pembayaran" label-cols-md="5">
            <b-form-datepicker v-model="utang.tanggal" />
          </b-form-group>
          <b-form-group label="Cara Pembayaran" label-cols-md="5">
            <v-select v-model="utang.caraPembayaran" placeholder="Cara Pembayaran" label="title" :options="caraPembayaran" :clearable="false" />
          </b-form-group>
        </b-col>
        <b-col cols="12" md="12" v-show="vTunai">
          <b-form-group label="Kas" label-cols-md="5">
            <v-select v-model="utang.kas" placeholder="Kas yang digunakan" label="title" :options="kasTunai" :clearable="false" />
            <small class="text-danger" v-show="utang.kas != ''">Uang akan mendebet {{ utang.kas.title }}</small>
          </b-form-group>
        </b-col>
        <b-col cols="12" md="12" v-show="vShowBank">
          <b-form-group label="Bank" label-cols-md="5">
            <v-select v-model="utang.bank" placeholder="Bank" label="title" :options="bank" :clearable="false" />
          </b-form-group>
        </b-col>
        <b-col cols="12" md="12">
          <b-form-group label="Jumlah" label-for="Jumlah" label-cols-md="5">
            <b-form-input id="Jumlah" v-model="utang.nominal" type="number" />
            <small class="text-danger" v-show="nominalError"> Jumlah nominal melebihi sisa Pembayaran </small>
          </b-form-group>
        </b-col>
        <b-col cols="12" md="12">
          <b-form-group label="Catatan" label-for="Catatan" label-cols-md="5">
            <b-form-textarea id="Catatan" v-model="utang.catatan" type="text" />
          </b-form-group>
        </b-col>
      </b-row>
    </section>
  </b-modal>
</template>

<script>
import { ref } from '@vue/composition-api'

import { BFormDatepicker, BCol, BRow, BFormTextarea, BFormGroup, BFormInput } from 'bootstrap-vue'

import vSelect from 'vue-select'

export default {
  components: {
    BFormDatepicker,
    BCol,
    BRow,
    BFormTextarea,
    BFormGroup,
    BFormInput,
    vSelect,
  },
  props: {
    dataUtang: {
      required: true,
      type: Object,
    },
  },
  computed: {
    kasTunai() {
      const userData = JSON.parse(localStorage.getItem('userData'))
      return [
        { title: `Kas Kasir - ${userData.cabang.nama}`, value: '0', kode_akun_id: userData.cabang.kode_akun_id },
        { title: `Kas Kasir - ${userData.pegawai.nama}`, value: '1', kode_akun_id: userData.kode_akun_id },
      ]
    },
  },
  watch: {
    utang: {
      deep: true,
      handler(x) {
        if (x.caraPembayaran.value === '1') {
          this.vShowBank = true
        } else {
          this.vShowBank = false
          this.utang.bank = ''
        }
        if (x.nominal > this.dataUtang.pembayaran.sisaPembayaran) {
          this.nominalError = true
        } else {
          this.nominalError = false
        }
        if (x.caraPembayaran.value === '0') {
          this.vTunai = true
        } else {
          this.vTunai = false
          this.utang.kas = ''
        }
      },
    },
  },
  methods: {
    loadBank() {
      this.$store.dispatch('app-transaksi-pembelian/fetchDataBank', this.dataOrder).then(res => {
        this.bank = res.data
      })
    },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
    validation() {
      if (this.utang.tanggal !== '' || this.utang.nominal !== 0 || this.utang.caraPembayaran !== '') {
        if (this.vTunai === true && this.utang.kas !== '') {
          return true
        }
        if (this.vShowBank === true && this.utang.bank !== '') {
          return true
        }
      }
      this.$swal({
        icon: 'error',
        title: 'Oopss!',
        text: 'Harap isi Form Pembayaran Utang dengan benar',
        customClass: {
          confirmButton: 'btn btn-success',
        },
      })
      return false
    },
    store(modalEvent) {
      modalEvent.preventDefault()
      if (this.validation()) {
        this.$store.dispatch('app-transaksi-pembelian/storeUtang', this.utang).then(res => {
          if (res.status === 200) {
            this.$swal({
              icon: 'success',
              title: 'Berhasil!',
              text: 'Pembayaran telah ditambahkan',
              customClass: {
                confirmButton: 'btn btn-success',
              },
            })
            this.$store.commit('app-transaksi-pembelian/UPDATE_PEMBAYARAN', {
              jenis: 'TAMBAH',
              nominal: res.data.nominal,
            })
            this.$store.commit('app-transaksi-pembelian/UPDATE_LIST_PEMBAYARAN', res.data)
          }
        })
        this.$bvModal.show('modal-pembayaran-utang')
      }
    },
  },
  mounted() {
    this.loadBank()
  },

  setup(props) {
    const caraPembayaran = ref([
      { title: 'Tunai', value: '0' },
      { title: 'Transfer', value: '1' },
    ])
    // const kasTunai = ref([
    //   { title: 'Kas Kecil Cabang', value: '0' },
    //   { title: 'Kas Kasir', value: '1' },
    // ])
    const nominalError = ref(false)
    const vShowBank = ref(false)
    const vTunai = ref(false)

    const utang = ref({
      kas: '',
      pembelian_id: props.dataUtang.id,
      nomor_jurnal: props.dataUtang.nomorJurnal,
      akun_utang_id: props.dataUtang.supplier.akun_utang_id,
      tanggal: '',
      nominal: 0,
      caraPembayaran: '',
      catatan: '',
      bank: '',
      user: JSON.parse(localStorage.getItem('userData')),
    })
    const dataInvoice = ref()
    const bank = ref()

    return {
      // kasTunai,
      vTunai,
      nominalError,
      caraPembayaran,
      utang,
      dataInvoice,
      bank,
      vShowBank,
    }
  },
}
</script>

<style lang="scss" scoped>
@import '@core/scss/vue/libs/vue-select.scss';
</style>
