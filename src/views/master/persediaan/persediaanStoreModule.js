import axios from '@axios'

export default {
  namespaced: true,
  state: {
    listGudang: [],
    listPersediaan: [],
    kartuPersediaan: [],
    listDataPenyesuaian: [],
    listDataTransfer: [],
  },
  getters: {
    getListGudang: state => state.listGudang,
    getListPersediaan: state => state.listPersediaan,
    getKartuPersediaan: state => state.kartuPersediaan,
    getListDataPenyesuaian: state => state.listDataPenyesuaian,
    getListDataTransfer: state => state.listDataTransfer,
  },
  mutations: {
    SET_LIST_GUDANG(state, data) {
      state.listGudang = data
    },
    SET_LIST_PERSEDIAAN(state, data) {
      state.listPersediaan = data
    },
    SET_KARTU_PERSEDIAAN(state, data) {
      state.kartuPersediaan = data
    },
    SET_LIST_DATA_PENYESUAIAN(state, data) {
      state.listDataPenyesuaian = data
    },
    SET_LIST_DATA_TRANSFER(state, data) {
      state.listDataTransfer = data
    },
    DELETE_LIST_DATA_TRANSFER(state, data) {
      const index = state.getListDataTransfer.findIndex(x => x.id === data)
      state.getListDataTransfer.splice(index, 1)
    },
  },
  actions: {
    fetchListGudang(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}gudang/${params.cabang}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchListPersediaan(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}persediaan/cabang/${params.cabang}/${params.gudang}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchKartuPersediaan(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}persediaan/${params.id}/gudang/${params.gudang_id}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    fetcListDataPenyesuaian(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}persediaan/penyesuaian/cabang/${params.cabang}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    fetcListDataTransfer(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}persediaan/transfer/cabang/${params.cabang}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    storePenyesuaianPersediaan(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}persediaan/store`, data)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    storeTransferPersediaan(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}persediaan/transfer`, data)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    destroyTransferPersediaan(ctx, { id }) {
      return new Promise((resolve, reject) => {
        axios
          .delete(`${axios.defaults.baseURL}persediaan/transfer/destroy/${id}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
  },
}
