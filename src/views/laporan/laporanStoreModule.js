import axios from '@axios'

export default {
  namespaced: true,
  state: {},
  getters: {},
  mutations: {},
  actions: {
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
