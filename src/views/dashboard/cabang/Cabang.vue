<template>
  <section id="dashboard-analytics">
    <b-row class="match-height">
      <b-col lg="8" md="12">
        <cabang-nama />
      </b-col>
      <b-col lg="4" md="12">
        <cabang-kas
          :sub-title="`s/d hari ini`"
          :label="`Saldo Utang`"
          :statistic="formatRupiah(dataUtangDagang)"
          :route="{
            name: 'keuangan-utang-piutang',
          }"
        />
        <cabang-kas
          :label="`Saldo Kas`"
          :sub-title="`s/d hari ini`"
          :statistic="formatRupiah(dataKas)"
          :route="{
            name: 'kas-kasir',
          }"
        />
      </b-col>
      <b-col lg="3" sm="6">
        <statistic-card-with-area-chart
          icon="ShoppingBagIcon"
          :statistic="formatRupiah(dataOmset.total)"
          statistic-title="Omset Hari Ini"
          :chart-data="dataOmset.series"
          :chartLabel="dataOmset.label"
          :label="true"
        />
      </b-col>
      <b-col lg="3" sm="6">
        <statistic-card-with-area-chart
          icon="DollarSignIcon"
          color="warning"
          :statistic="formatRupiah(dataLabaHarian.total)"
          statistic-title="Harga Pokok Penjualan Hari Ini"
          :chart-data="dataLabaHarian.series"
          :chartLabel="dataLabaHarian.label"
          :label="true"
        />
      </b-col>

      <b-col lg="3" sm="6">
        <statistic-card-with-area-chart
          icon="DollarSignIcon"
          color="warning"
          :statistic="formatRupiah(dataBeban.total)"
          statistic-title="Beban Hari Ini"
          :chart-data="dataBeban.series"
          :chartLabel="dataBeban.label"
          :label="true"
        />
      </b-col>
      <b-col lg="3" sm="6">
        <statistic-card-with-area-chart
          icon="DollarSignIcon"
          color="warning"
          :statistic="formatRupiah(dataPersediaan.total)"
          statistic-title="Persediaan Hari Ini"
          :chart-data="dataPersediaan.series"
          :chartLabel="dataPersediaan.label"
          :label="true"
        />
      </b-col>
    </b-row>
    <b-row>
      <b-col lg="9" md="12">
        <cabang-daftar-penjualan :data-transaksi="dataTransaksi" />
      </b-col>
    </b-row>
    <hr />
    <b-row>
      <b-col lg="9" md="12">
        <cabang-pendapatan :data="dataLabaBulanan" @tahunLaba="tahunLaba" />
      </b-col>
    </b-row>
  </section>
</template>
<script>
import store from '@/store'
import { ref } from '@vue/composition-api'

import { BRow, BCol } from 'bootstrap-vue'

import StatisticCardWithAreaChart from '@core/components/statistics-cards/StatisticCardWithAreaChart.vue'
import { formatRupiah, kFormatter } from '@core/utils/filter'
// import InvoiceList from '@/views/apps/invoice/invoice-list/InvoiceList.vue'
import CabangNama from './CabangNama.vue'
import CabangKas from './CabangKas.vue'
import CabangDaftarPenjualan from './CabangDaftarPenjualan.vue'
import CabangPendapatan from './CabangPendapatan.vue'
// import AnalyticsAvgSessions from './AnalyticsAvgSessions.vue'
// import AnalyticsSupportTracker from './AnalyticsSupportTracker.vue'
// import AnalyticsTimeline from './AnalyticsTimeline.vue'
// import AnalyticsSalesRadarChart from './AnalyticsSalesRadarChart.vue'
// import AnalyticsAppDesign from './AnalyticsAppDesign.vue'

export default {
  components: {
    BRow,
    BCol,
    CabangNama,
    CabangKas,
    CabangDaftarPenjualan,
    CabangPendapatan,
    // AnalyticsAvgSessions,
    StatisticCardWithAreaChart,
    // AnalyticsSupportTracker,
    // AnalyticsTimeline,
    // AnalyticsSalesRadarChart,
    // AnalyticsAppDesign,
    // InvoiceList,
  },
  data() {
    return {
      dataOmset: {
        series: [],
        label: [],
        total: 0,
      },
      dataLabaHarian: {
        series: [],
        label: [],
        total: 0,
      },
      dataLabaBulanan: {},
      dataBeban: {
        series: [],
        label: [],
        total: 0,
      },
      dataPersediaan: {
        series: [],
        label: [],
        total: 0,
      },
      dataKas: 0,
      dataUtangDagang: 0,
      tahunLabaBulanan: '2021',
    }
  },
  watch: {
    tahunLabaBulanan() {
      store.dispatch('app-dashboard-cabang/fetchLabaBulanan', { tahun: this.tahunLabaBulanan, cabang_id: this.user.cabang_id }).then(res => {
        if (res.status === 200) {
          this.dataLabaBulanan = res.data
        }
      })
    },
  },
  created() {
    store.dispatch('app-dashboard-cabang/fetchPersediaanHarian', { cabang_id: this.user.cabang_id }).then(res => {
      if (res.status === 200) {
        // store.commit('app-dashboard-cabang/SET_LIST_OMSET_HARIAN', this.dataOrder)
        this.dataPersediaan.series.push(res.data.series)
        this.dataPersediaan.label = res.data.label
        this.dataPersediaan.total = res.data.total
      }
    })
    store.dispatch('app-dashboard-cabang/fetchOmsetHarian', { cabang_id: this.user.cabang_id }).then(res => {
      if (res.status === 200) {
        // store.commit('app-dashboard-cabang/SET_LIST_OMSET_HARIAN', this.dataOrder)
        this.dataOmset.series.push(res.data.series)
        this.dataOmset.label = res.data.label
        this.dataOmset.total = res.data.total
      }
    })
    store.dispatch('app-dashboard-cabang/fetchLabaHarian', { hari: 5, cabang_id: this.user.cabang_id }).then(res => {
      if (res.status === 200) {
        // store.commit('app-dashboard-cabang/SET_LIST_OMSET_HARIAN', this.dataOrder)
        this.dataLabaHarian.series.push(res.data.series)
        this.dataLabaHarian.label = res.data.label
        this.dataLabaHarian.total = res.data.total
      }
    })
    store.dispatch('app-dashboard-cabang/fetchLabaBulanan', { tahun: this.tahunLabaBulanan, cabang_id: this.user.cabang_id }).then(res => {
      if (res.status === 200) {
        this.dataLabaBulanan = res.data
      }
    })
    store.dispatch('app-dashboard-cabang/fetchBebanHarian', { hari: 5, cabang_id: this.user.cabang_id }).then(res => {
      if (res.status === 200) {
        // store.commit('app-dashboard-cabang/SET_LIST_OMSET_HARIAN', this.dataOrder)
        this.dataBeban.series.push(res.data.series)
        this.dataBeban.label = res.data.label
        this.dataBeban.total = res.data.total
      }
    })
    store
      .dispatch('app-transaksi-penjualan/fetchListTransaksiPenjualan', {
        cabang: this.user.cabang_id,
        dateawal: this.$moment(new Date()).format('YYYY-MM-DD'),
        dateakhir: this.$moment(new Date()).format('YYYY-MM-DD'),
      })
      .then(res => {
        store.commit('app-transaksi-penjualan/SET_LIST_TRANSAKSI_PENJUALAN', res.data)
        this.dataTransaksi = store.getters['app-transaksi-penjualan/getListTransaksiPenjualan']
        this.dataTemp = store.getters['app-transaksi-penjualan/getListTransaksiPenjualan']
      })
    store
      .dispatch('app-dashboard-cabang/fetchKasHarian', {
        cabang_id: this.user.cabang_id,
      })
      .then(res => {
        this.dataKas = res.data
      })
    store
      .dispatch('app-dashboard-cabang/fetchUtang', {
        cabang_id: this.user.cabang_id,
      })
      .then(res => {
        this.dataUtangDagang = res.data
      })
  },
  methods: {
    kFormatter,
    formatRupiah,
    tahunLaba(x) {
      this.tahunLabaBulanan = x
    },
  },

  setup() {
    const dataTransaksi = ref([])
    const user = JSON.parse(localStorage.getItem('userData'))

    return {
      dataTransaksi,
      user,
    }
  },
}
</script>

<style lang="scss">
@import '@core/scss/vue/pages/dashboard-ecommerce.scss';
</style>
