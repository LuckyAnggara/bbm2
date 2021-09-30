import Vue from 'vue'
import Vuex from 'vuex'
/* eslint-disable */
// Modules
import ecommerceStoreModule from '@/views/apps/e-commerce/eCommerceStoreModule'
import userStoreModule from '@/views/auth/userStoreModule'
import keuanganStoreModule from '@/views/keuangan/keuanganStoreModule'
import laporanStoreModule from '@/views/laporan/laporanStoreModule'
import pegawaiStoreModule from '@/views/kepegawaian/pegawaiStoreModule'
import barangStoreModule from '@/views/master/barang/barangStoreModule'
import kontakStoreModule from '@/views/master/kontak/kontakStoreModule'
import gudangStoreModule from '@/views/master/gudang/gudangStoreModule'
import persediaanStoreModule from '@/views/master/persediaan/persediaanStoreModule'
import transaksiPenjualanStoreModule from '@/views/transaksi/transaksiPenjualanStoreModule'
import transaksiPembelianStoreModule from '@/views/transaksi/transaksiPembelianStoreModule'
import dashboardCabangStoreModule from '@/views/dashboard/dashboardCabangStoreModule'
import poStoreModule from '@/views/transaksi/poStoreModule'
import cabangStoreModule from '@/views/master/cabang/cabangStoreModule'
import app from './app'
import appConfig from './app-config'
import verticalMenu from './vertical-menu'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    app,
    appConfig,
    verticalMenu,
    'app-user': userStoreModule,
    'app-keuangan': keuanganStoreModule,
    'app-laporan': laporanStoreModule,
    'app-pegawai': pegawaiStoreModule,
    'app-ecommerce': ecommerceStoreModule,
    'app-barang': barangStoreModule,
    'app-kontak': kontakStoreModule,
    'app-gudang': gudangStoreModule,
    'app-persediaan': persediaanStoreModule,
    'app-transaksi-penjualan': transaksiPenjualanStoreModule,
    'app-transaksi-pembelian': transaksiPembelianStoreModule,
    'app-po': poStoreModule,
    'app-dashboard-cabang': dashboardCabangStoreModule,
    'app-cabang': cabangStoreModule,
  },
  strict: process.env.DEV,
})
