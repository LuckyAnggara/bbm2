<template>
  <section>
    <b-tabs pills>
      <b-tab title="Penjualan" lazy>
        <transaksi-penjualan />
      </b-tab>
      <b-tab title="Retur" lazy>
        <transaksi-retur />
      </b-tab>
    </b-tabs>
  </section>
</template>

<script>
// import store from '@/store'

import { BTab, BTabs } from 'bootstrap-vue'

import TransaksiPenjualan from './component/TransaksiPenjualan.vue'
import TransaksiRetur from './component/TransaksiRetur.vue'

export default {
  components: {
    TransaksiPenjualan,
    TransaksiRetur,
    BTab,
    BTabs,
  },
  // methods: {
  //   loadData(dateawal = null, dateakhir = null) {
  //     const user = JSON.parse(localStorage.getItem('userData'))
  //     const cabang = user.cabang_id
  //     store
  //       .dispatch('app-transaksi-penjualan/fetchListTransaksiPenjualan', {
  //         cabang,
  //         dateawal,
  //         dateakhir,
  //       })
  //       .then(res => {
  //         store.commit('app-transaksi-penjualan/SET_LIST_TRANSAKSI_PENJUALAN', res.data)
  //       })
  //   },
  //   loadAwal() {
  //     // const d = new Date()
  //     // const m = d.getMonth()
  //     // const y = d.getFullYear()
  //     // this.loadData(this.$moment(new Date(y, m, 1)), this.$moment(Date.now()))
  //     this.loadData()
  //   },
  // },
  // mounted() {
  //   this.loadAwal()
  // },
}
</script>
