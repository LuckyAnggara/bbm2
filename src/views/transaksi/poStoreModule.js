import axios from '@axios'

export default {
  namespaced: true,
  state: {
    listPOKeluar: [],
    listPOMasuk: [],
  },
  getters: {
    getListPOKeluar: state => state.listPOKeluar,
    getListPOMasuk: state => state.listPOMasuk,
  },
  mutations: {
    SET_LIST_PO_KELUAR(state, data) {
      state.listPOKeluar = data
    },
    SET_LIST_PO_MASUK(state, data) {
      state.listPOMasuk = data
    },
    UPDATE_PO(state, data) {
      state.listPOKeluar.push(data)
    },
    BATAL_PO(state, data) {
      const index = state.listPOKeluar.findIndex(x => x.id === data)
      state.listPOKeluar[index].status_po = 'DIBATALKAN'
    },
    REMOVE_PO(state, data) {
      const index = state.listPOKeluar.findIndex(x => x.id === data)
      state.listPOKeluar.splice(index, 1)
    },
  },
  actions: {
    showDataInvoice(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}po/show-invoice?nomor_transaksi=${data.nomor_transaksi}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    listPOKeluar(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}po/keluar?cabang_id=${data.cabang_id}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    listPOMasuk(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}po/masuk?cabang_id=${data.cabang_id}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    showData(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}po/show?id=${data.id}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    updateStatus(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}po/update-status`, data)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    fetchPO(ctx, id) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}po/detail?po_id=${id}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    storePO(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}po/store`, data)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    batalPO(ctx, { id }) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}po/batal?id=${id}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    deletePO(ctx, { id }) {
      return new Promise((resolve, reject) => {
        axios
          .delete(`${axios.defaults.baseURL}po/delete/${id}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    selesaiPO(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}po/selesai`, data)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
  },
}
