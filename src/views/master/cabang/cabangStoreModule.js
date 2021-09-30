import axios from '@axios'

export default {
  namespaced: true,
  state: {
    listDataPerformance: [],
    listDataPerformanceSatuan: [],
    // listDataKas: [],
  },
  getters: {
    getListDataPerformance: state => state.listDataPerformance,
    getListDataPerformanceSatuan: state => state.listDataPerformanceSatuan,
    // getListDataKas: state => state.listDataKas,
  },
  mutations: {
    SET_LIST_DATA_PERFORMANCE(state, data) {
      state.listDataPerformance = data
    },
    SET_LIST_DATA_PERFORMANCE_SATUAN(state, data) {
      state.listDataPerformanceSatuan = data
    },
    // SET_LIST_DATA_KAS(state, data) {
    //   state.listDataKas = data
    // },
  },
  actions: {
    fetchDataPerformanceAll(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.keuanganURL}cabang/performance-all?tahun=${params.tahun}&bulan=${params.bulan}&hari=${params.hari}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchDataPerformanceSatuan(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.keuanganURL}cabang/performance-satuan?cabang_id=${params.cabang_id}&awal=${params.awal}&akhir=${params.akhir}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchDataKas(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.keuanganURL}cabang/kas?cabang_id=${params.cabang_id}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
  },
}
