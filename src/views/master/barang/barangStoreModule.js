import axios from '@axios'

export default {
  namespaced: true,
  state: {
    listBarang: [],
    listGudang: [],
    jenis: [],
    satuan: [],
    merek: [],
    barang: '',
    // PERSEDIAAN
    listDetailPersediaan: [],
  },
  getters: {
    getListBarang: state => state.listBarang,
    getListGudang: state => state.listGudang,
    getListJenis: state => state.jenis,
    getListMerek: state => state.merek,
    getListSatuan: state => state.satuan,
    getBarangById: state => id => state.listBarang.find(x => x.id === id),
    // PERSEDIAAN
    getDetailListPersediaan: state => state.listDetailPersediaan,
  },
  mutations: {
    SET_LIST_BARANG(state, data) {
      state.listBarang = data
    },
    SET_LIST_GUDANG(state, data) {
      state.listGudang = data
    },
    SET_LIST_JENIS(state, data) {
      state.jenis = data
    },
    SET_LIST_MEREK(state, data) {
      state.merek = data
    },
    SET_LIST_SATUAN(state, data) {
      state.satuan = data
    },
    UPDATE_LIST_BARANG(state, data) {
      state.listBarang.push(data)
    },
    UPDATE_LIST_GUDANG(state, data) {
      state.listGudang.push(data)
    },
    UPDATE_LIST_JENIS(state, data) {
      state.jenis.push(data)
    },
    UPDATE_LIST_MEREK(state, data) {
      state.merek.push(data)
    },
    UPDATE_LIST_SATUAN(state, data) {
      state.satuan.push(data)
    },
    REMOVE_LIST_BARANG(state, data) {
      state.listBarang.splice(
        state.listBarang.findIndex(x => x.id === data),
        1,
      )
    },
    // PERSEDIAAN
    SET_LIST_DETAIL_PERSEDIAAN(state, data) {
      state.listDetailPersediaan = data
    },
  },
  actions: {
    fetchBarangById(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}barang/detail?id=${params.id}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchListBarang(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}barang?cabang_id=${data.cabang_id}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchListGudang(ctx, queryParams) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}barang/gudang`, {
            params: queryParams,
          })
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    // JENIS SATUAN MEREK
    fetchListJenis(ctx, queryParams) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}barang/jenis`, {
            params: queryParams,
          })
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchListSatuan(ctx, queryParams) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}barang/satuan`, {
            params: queryParams,
          })
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },

    fetchListMerek(ctx, queryParams) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}barang/merek`, {
            params: queryParams,
          })
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    addBarang(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}barang/store`, data)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    addGudang(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}barang/gudang/store`, data)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    addHargaBarang(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}barang/harga/store`, data)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    addJenis(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}barang/satuan/store`, data)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    addMerek(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}barang/merek/store`, data)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    addSatuan(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}barang/satuan/store`, data)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    removeBarang(ctx, { id }) {
      return new Promise((resolve, reject) => {
        axios
          .delete(`${axios.defaults.baseURL}barang/${id}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    removeHarga(ctx, { id }) {
      return new Promise((resolve, reject) => {
        axios
          .delete(`${axios.defaults.baseURL}barang/harga/${id}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    // PERSEDIAAN
    fetchDetailPersediaan(ctx, { id }) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}persediaan/${id}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
  },
}
