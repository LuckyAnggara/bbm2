<template>
  <b-modal centered size="lg" id="modal-pembayaran-piutang" title="Pembayaran Piutang" ok-title="Proses" cancel-variant="outline-secondary" @ok="store">
    <!-- <b-modal id="modal-default" ref="my-modal" ok-only ok-title="Submit" centered :title="detailBarang.nama"> -->
    <section>
      <b-row>
        <b-col cols="12" md="12" class="mb-2">
          <p class="text-muted">
            Sisa piutang Nomor Transaksi {{ dataPiutang.nomorTransaksi }} : <b>{{ formatRupiah(dataPiutang.pembayaran.sisaPembayaran) }}</b>
          </p>
        </b-col>
        <b-col cols="12" md="12">
          <b-form-group label="Tanggal Pembayaran" label-cols-md="5">
            <b-form-datepicker v-model="piutang.tanggal" />
          </b-form-group>
          <b-form-group label="Cara Pembayaran" label-cols-md="5">
            <v-select v-model="piutang.caraPembayaran" placeholder="Cara Pembayaran" label="title" :options="caraPembayaran" :clearable="false" />
          </b-form-group>
        </b-col>
        <b-col cols="12" md="12" v-show="vShowBank">
          <b-form-group label="Bank" label-cols-md="5">
            <v-select v-model="piutang.bank" placeholder="Bank" label="title" :options="bank" :clearable="false" />
          </b-form-group>
        </b-col>
        <b-col cols="12" md="12">
          <b-form-group label="Jumlah" label-for="Jumlah" label-cols-md="5">
            <b-form-input id="Jumlah" v-model="piutang.nominal" type="number" />
            <small class="text-danger" v-show="nominalError"> Jumlah nominal melebiha Sisa Pembayaran </small>
          </b-form-group>
        </b-col>
        <b-col cols="12" md="12">
          <b-form-group label="Catatan" label-for="Catatan" label-cols-md="5">
            <b-form-textarea id="Catatan" v-model="piutang.catatan" type="text" />
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
    dataPiutang: {
      required: true,
      type: Object,
    },
  },
  watch: {
    piutang: {
      deep: true,
      handler(x) {
        if (x.caraPembayaran.value === '1') {
          this.vShowBank = true
        } else {
          this.vShowBank = false
          this.piutang.bank = ''
        }
        if (x.nominal > this.dataPiutang.pembayaran.sisaPembayaran) {
          this.nominalError = true
        } else {
          this.nominalError = false
        }
      },
    },
  },
  methods: {
    show(data) {
      this.$emit('destroy', data)
    },
    loadBank() {
      this.$store.dispatch('app-transaksi-penjualan/fetchDataBank', this.dataOrder).then(res => {
        this.bank = res.data
      })
    },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
    store() {
      this.$store.dispatch('app-transaksi-penjualan/storePiutang', this.piutang).then(res => {
        console.info(res)
      })
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
    const nominalError = ref(false)
    const vShowBank = ref(false)
    const piutang = ref({
      penjualan_id: props.dataPiutang.id,
      nomor_jurnal: props.dataPiutang.nomorJurnal,
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
      nominalError,
      caraPembayaran,
      piutang,
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
