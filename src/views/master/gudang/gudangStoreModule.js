import axios from '@axios'

export default {
  namespaced: true,
  state: {
    listGudang: [],
  },
  getters: {
    getListGudang: state => state.listGudang,
  },
  mutations: {
    SET_LIST_GUDANG(state, data) {
      state.listGudang = data
    },
    // PELANGGAN
    UPDATE_LIST_GUDANG(state, data) {
      state.listGudang.push(data)
    },
    REMOVE_LIST_GUDANG(state, data) {
      state.listSupplier.splice(data, 1)
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
    addGudang(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}gudang/store`, data)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    removePelanggan(ctx, { id }) {
      return new Promise((resolve, reject) => {
        axios
          .delete(`${axios.defaults.baseURL}gudang/${id}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
  },
}
