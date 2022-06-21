<template>
  <section id="dashboard-analytics">
    <b-row class="match-height">
      <b-col lg="4" md="12">
        <cabang-kas
          :label="`Saldo Kas Tunai`"
          :sub-title="`s/d hari ini`"
          :statistic="formatRupiah(dataKasTunai)"
          :route="{
            name: 'kas-kasir',
          }"
        />
      </b-col>
    </b-row>

    <hr />
    <b-row class="match-height">
      <b-col lg="9" md="12">
        <cabang-daftar-penjualan :data-transaksi="dataTransaksi" />
      </b-col>
    </b-row>
  </section>
</template>
<script>
import store from '@/store'
import { ref } from '@vue/composition-api'

import { BRow, BCol } from 'bootstrap-vue'

import { formatRupiah, kFormatter } from '@core/utils/filter'
// import InvoiceList from '@/views/apps/invoice/invoice-list/InvoiceList.vue'
import CabangKas from '@/views/dashboard/cabang/CabangKas.vue'
import CabangDaftarPenjualan from '@/views/dashboard/cabang/CabangDaftarPenjualan.vue'
// import AnalyticsAvgSessions from './AnalyticsAvgSessions.vue'
// import AnalyticsSupportTracker from './AnalyticsSupportTracker.vue'
// import AnalyticsTimeline from './AnalyticsTimeline.vue'
// import AnalyticsSalesRadarChart from './AnalyticsSalesRadarChart.vue'
// import AnalyticsAppDesign from './AnalyticsAppDesign.vue'

export default {
  components: {
    BRow,
    BCol,
    CabangKas,
    CabangDaftarPenjualan,
    // AnalyticsSupportTracker,
    // AnalyticsTimeline,
    // AnalyticsSalesRadarChart,
    // AnalyticsAppDesign,
    // InvoiceList,
  },
  data() {
    return {
      dataKasTunai: 0,
    }
  },
  watch: {
    tahunLabaBulanan() {
      store.dispatch('app-dashboard-cabang/fetchLabaBulanan', { tahun: this.tahunLabaBulanan, cabang_id: this.userData.cabang_id }).then(res => {
        if (res.status === 200) {
          this.dataLabaBulanan = res.data
        }
      })
    },
  },
  created() {
    store
      .dispatch('app-transaksi-penjualan/fetchListTransaksiPenjualan', {
        cabang: this.userData.cabang_id,
        dateawal: this.$moment(new Date()).format('YYYY-MM-DD'),
        dateakhir: this.$moment(new Date()).format('YYYY-MM-DD'),
      })
      .then(res => {
        store.commit('app-transaksi-penjualan/SET_LIST_TRANSAKSI_PENJUALAN', res.data)
        this.dataTransaksi = store.getters['app-transaksi-penjualan/getListTransaksiPenjualan']

        if (this.userData.role.nama === 'KASIR') {
          this.dataTransaksi = store.getters['app-transaksi-penjualan/getListTransaksiPenjualan'].filter(x => x.user.id === this.userData.id)
        }
      })
    store
      .dispatch('app-dashboard-cabang/fetchKasHarian', {
        cabang_id: this.userData.cabang_id,
        akun_id: this.userData.role.nama === 'KASIR' ? this.userData.kode_akun_id : '',
      })
      .then(res => {
        this.dataKasTunai = res.data.tunai
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
    const userData = JSON.parse(localStorage.getItem('userData'))
    console.info(userData)
    return {
      dataTransaksi,
      userData,
    }
  },
}
</script>

<style lang="scss">
@import '@core/scss/vue/pages/dashboard-ecommerce.scss';
</style>
