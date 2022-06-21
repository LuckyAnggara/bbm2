import axios from '@axios'

export default {
  namespaced: true,
  state: {
    listOmsetHarian: [],
    listOmsetBulanan: [],
    listMargin: [],
    laba: '',
  },
  getters: {
    // getListOmsetHarian: state => state.listOmsetHarian,
    // getListOmsetBulanan: state => state.listOmsetHarian,
  },
  mutations: {
    // SET_LIST_OMSET_HARIAN(state, data) {
    //   state.listOmsetHarian = data
    // },
  },
  actions: {
    fetchOmsetHarian(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.keuanganURL}dashboard-cabang/omset-harian?cabang_id=${data.cabang_id}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    fetchLabaHarian(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.keuanganURL}dashboard-cabang/laba-harian?cabang_id=${data.cabang_id}&hari=${data.hari}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    fetchLabaBulanan(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.keuanganURL}dashboard-cabang/laba-bulanan?cabang_id=${data.cabang_id}&tahun=${data.tahun}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    fetchBebanHarian(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.keuanganURL}dashboard-cabang/beban-harian?cabang_id=${data.cabang_id}&hari=${data.hari}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    fetchPersediaanHarian(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.keuanganURL}dashboard-cabang/persediaan-harian?cabang_id=${data.cabang_id}&hari=${data.hari}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    fetchKasHarian(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.keuanganURL}dashboard-cabang/kas-harian?cabang_id=${data.cabang_id}&akun_id=${data.akun_id}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    fetchUtang(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.keuanganURL}dashboard-cabang/utang-harian?cabang_id=${data.cabang_id}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    // SALES
    fetchAllPerformanceSales(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}sales/all-performance?cabang_id=${data.cabang_id}&tahun=${data.tahun}&bulan=${data.bulan}&hari=${data.hari}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
  },
}
