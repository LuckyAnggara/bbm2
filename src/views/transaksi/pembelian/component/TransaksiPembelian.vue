<template>
  <section>
    <b-row class="match-height">
      <b-col lg="3" cols="12">
        <b-card>
          <b-form-group>
            <h5>Filter</h5>
            <hr />
            <h6 class="mb-1">Tanggal Transaksi</h6>
            <b-input-group>
              <flat-pickr v-model="date.value" class="form-control" :config="date.config" placeholder="Filter By Tanggal" />
              <b-input-group-append>
                <b-button variant="outline-primary" @click="clear">
                  Clear
                </b-button>
              </b-input-group-append>
            </b-input-group>
          </b-form-group>
        </b-card>
      </b-col>
      <b-col lg="9" cols="12">
        <statistik :data-transaksi="dataTransaksi" />
      </b-col>
      <b-col lg="12" cols="12">
        <b-card>
          <table-transaksi-pembelian
            @destroy="destroyId"
            @retur="returId"
            @searchdata="searchQuery"
            @filterdata="filterQuery"
            :dataTransaksi="dataTransaksi"
            :dataTemp="dataTemp"
            :typeRetur="false"
            :tanggalData="tanggal"
          />
        </b-card>
      </b-col>
    </b-row>
  </section>
</template>

<script>
import store from '@/store'
import { ref } from '@vue/composition-api'

import { BCard, BRow, BCol, BInputGroupAppend, BFormGroup, BInputGroup, BButton } from 'bootstrap-vue'
import flatPickr from 'vue-flatpickr-component'
import Statistik from './Statistik.vue'
import TableTransaksiPembelian from './TableTransaksiPembelian.vue'

export default {
  components: {
    TableTransaksiPembelian,
    BFormGroup,
    BInputGroupAppend,
    BInputGroup,
    flatPickr,
    Statistik,
    BCard,
    BRow,
    BCol,
    BButton,
  },
  data() {
    return {
      tanggal: {
        awal: '',
        akhir: '',
      },
      date: {
        value: '',
        config: {
          wrap: true, // set wrap to true only when using 'input-group'
          altFormat: 'd F Y',
          altInput: true,
          dateFormat: 'Y-m-d',
          mode: 'range',
        },
      },
      refTable: null,
    }
  },
  computed: {
    totalInvoices() {
      return this.dataTransaksi.length
    },
    dateFilter() {
      return this.date.value
    },
  },
  watch: {
    dateFilter(x) {
      if (x === '') {
        this.loadTransaksi()
      } else {
        const d = x.split(' to ')
        if (d.length > 1) {
          this.loadTransaksi(this.$moment(d[0]), this.$moment(d[1]))
        } else {
          this.loadTransaksi(this.$moment(d[0]), this.$moment(d[0]))
        }
      }
    },
  },
  methods: {
    returId(data) {
      const { id } = data.item
      this.$swal({
        title: 'Retur data ?',
        text: 'Data transaksi pembelian akan di retur',
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
          store
            .dispatch('app-transaksi-pembelian/returTransaksi', {
              id,
            })
            .then(x => {
              if (x.status === 200) {
                store.commit('app-transaksi-pembelian/RETUR_DATA_PEMBELIAN', id)
                store.dispatch('app-keuangan/returJurnal', x.data).then(d => {
                  if (d.status === 200) {
                    this.$swal({
                      icon: 'success',
                      title: 'Transaksi sudah di Retur!',
                      customClass: {
                        confirmButton: 'btn btn-success',
                      },
                    })
                  } else {
                    this.$swal({
                      icon: 'error',
                      title: 'Oopps!! Kesalahan',
                      customClass: {
                        confirmButton: 'btn btn-success',
                      },
                    })
                  }
                })
              } else {
                this.$swal({
                  icon: 'error',
                  title: 'Oopps!! Kesalahan',
                  customClass: {
                    confirmButton: 'btn btn-success',
                  },
                })
              }
            })
        }
      })
    },
    destroyId(data) {
      const { id } = data.item
      this.$swal({
        title: 'Delete data ?',
        text: 'Data pembelian akan di hapus',
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
          store
            .dispatch('app-transaksi-pembelian/deleteTransaksi', {
              id,
            })
            .then(x => {
              if (x.status === 200) {
                store.commit('app-transaksi-pembelian/REMOVE_DATA_PEMBELIAN', id)
                store.dispatch('app-keuangan/removeJurnal', x).then(d => {
                  if (d.status === 200) {
                    this.$swal({
                      icon: 'success',
                      title: 'Deleted!',
                      customClass: {
                        confirmButton: 'btn btn-success',
                      },
                    })
                  } else {
                    this.$swal({
                      icon: 'error',
                      title: 'Oopps!! Kesalahan',
                      customClass: {
                        confirmButton: 'btn btn-success',
                      },
                    })
                  }
                })
              } else {
                this.$swal({
                  icon: 'error',
                  title: 'Oopps!! Kesalahan',
                  customClass: {
                    confirmButton: 'btn btn-success',
                  },
                })
              }
            })
        }
      })
    },
    searchQuery(query) {
      if (query === '') {
        this.dataTransaksi = this.dataTemp
      } else {
        this.dataTransaksi = this.dataTemp.filter(
          item => item.nomorTransaksi.toLowerCase().indexOf(query.toLowerCase()) > -1 || item.supplier.nama.toLowerCase().indexOf(query.toLowerCase()) > -1,
        )
      }
    },
    filterQuery(query) {
      if (query === 'Lunas') {
        this.dataTransaksi = this.dataTemp.filter(trx => trx.pembayaran.sisaPembayaran === null || trx.pembayaran.sisaPembayaran === 0)
      } else if (query === 'Kredit') {
        this.dataTransaksi = this.dataTemp.filter(trx => parseFloat(trx.pembayaran.sisaPembayaran) >= 0 && trx.pembayaran.statusPembayaran.value === 1)
      } else if (query === null || query === '') {
        this.dataTransaksi = this.dataTemp
      }
    },
    clear() {
      this.date.value = ''
    },
    moment(value) {
      return this.$moment(value).format('DD MMMM YYYY')
    },
    formatRupiah(value) {
      return `Rp. ${value.toFixed(0).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
    loadTransaksi(dateawal = null, dateakhir = null) {
      this.tanggal.awal = dateawal
      this.tanggal.akhir = dateakhir
      const user = JSON.parse(localStorage.getItem('userData'))
      const cabang = user.cabang_id
      store
        .dispatch('app-transaksi-pembelian/fetchListTransaksiPembelian', {
          cabang,
          dateawal,
          dateakhir,
        })
        .then(res => {
          store.commit('app-transaksi-pembelian/SET_LIST_TRANSAKSI_PEMBELIAN', res.data)
          this.dataTransaksi = store.getters['app-transaksi-pembelian/getListTransaksiPembelian']
          this.dataTemp = store.getters['app-transaksi-pembelian/getListTransaksiPembelian']
        })
    },
    loadAwal() {
      // const d = new Date()
      // const m = d.getMonth()
      // const y = d.getFullYear()
      // this.loadTransaksi(this.$moment(new Date(y, m, 1)), this.$moment(Date.now()))
      this.loadTransaksi()
    },
  },
  mounted() {
    this.loadAwal()
  },
  setup() {
    const dataTransaksi = ref([])
    const dataTemp = ref([])

    return {
      dataTransaksi,
      dataTemp,
    }
  },
}
</script>

<style lang="scss" scoped>
.per-page-selector {
  width: 90px;
}
</style>

<style lang="scss">
@import '@core/scss/vue/libs/vue-flatpicker.scss';
</style>
