import axios from '@axios'

export default {
  namespaced: true,
  state: {},
  getters: {},
  mutations: {},
  actions: {
    laporanCabang(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}laporan/cabang?cabang_id=${params.cabang_id}&tahun=${params.tahun}&bulan=${params.bulan}&hari=${params.hari}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    laporanKasir(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}laporan/kasir?kasir_id=${params.kasir_id}&hari=${params.tanggal}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    laporanPersediaan(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}laporan/persediaan?cabang_id=${params.cabang}&gudang_id=${params.gudang}&tanggal_akhir=${params.tanggal}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    laporanTransaksiPenjualan(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(
            `${axios.defaults.baseURL}laporan/transaksi-penjualan?cabang_id=${params.cabang}&tanggal_awal=${params.tanggal_awal}&tanggal_akhir=${params.tanggal_akhir}&status=${params.status}`,
          )
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
  },
}
