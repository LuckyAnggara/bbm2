import axios from '@axios'

export default {
  namespaced: true,
  state: {
    listDataPerformance: [],
    listDataPerformanceSatuan: [],
    listCabang: [],
    // listDataKas: [],
  },
  getters: {
    getListCabang: state => state.listCabang,
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
    SET_LIST_CABANG(state, data) {
      state.listCabang = data
    },
  },
  actions: {
    fetchDataCabang(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}cabang/`, data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchDetailCabang(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}cabang/detail?cabang_id=${params.id}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
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
    confirmSetoran(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}setor/confirm`, data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    tambahCabang(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}cabang/store`, data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    updateCabang(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}cabang/update`, data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
  },
}
