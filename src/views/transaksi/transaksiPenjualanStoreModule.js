import axios from '@axios'

export default {
  namespaced: true,
  state: {
    // PENJUALAN
    draftPenjualan: [],
    activePenjualan: '',
    activeDataInvoice: '',
    activeOrder: '',
    listPenjualan: [],
    listPenjualanRetur: [],
  },
  getters: {
    // PENJUALAN
    getJumlahPenjualan: state => state.draftPenjualan.length,
    getActiveOrder: state => state.activeOrder,
    getActivePenjualan: state => state.activePenjualan,
    getDataInvoice: state => state.activeDataInvoice,

    // DRAFT TRANSAKSI PENJUALAN
    getListDraftPenjualan: state => state.draftPenjualan,
    getDraftByID: state => nomor => state.draftPenjualan.find(x => x.nomor === nomor),
    // TRANSAKSI PENJUALAN
    getListTransaksiPenjualan: state => state.listPenjualan,
    getListTransaksiPenjualanRetur: state => state.listPenjualanRetur,
    getTransaksiByBarang: state => kodeBarang => state.listPenjualan.filter(x => x.orders.kode_barang_id === kodeBarang),
  },
  mutations: {
    // PENJUALAN TRANSAKSI
    SET_ACTIVE_ORDER(state, data) {
      state.activeOrder = data
    },
    SET_ACTIVE_PENJUALAN(state, data) {
      state.activePenjualan = data
    },
    SET_DATA_INVOICE(state, data) {
      state.activeDataInvoice = data
    },
    SET_INVOICE(state, data) {
      state.activePenjualan.invoice = data
    },
    ADD_ORDER_TO_ACTIVE_PENJUALAN(state, data) {
      state.activePenjualan.orders = data
    },

    // DATA DRAFT TRANSAKSI PENJUALAN
    ADD_DRAFT_PENJUALAN(state, data) {
      const exist = state.draftPenjualan.find(x => x.nomor === data.nomor)
      if (exist === undefined) {
        state.draftPenjualan.push(data)
      }
    },
    REMOVE_DRAFT_PENJUALAN(state, data) {
      state.draftPenjualan.splice(data, 1)
    },
    // DATA LIST TRANSAKSI PENJUALAN
    SET_LIST_TRANSAKSI_PENJUALAN(state, data) {
      state.listPenjualan = data.filter(x => x.retur === 'Tidak')
      state.listPenjualanRetur = data.filter(x => x.retur === 'Iya')
    },
    SET_DATA_INVOICE_FROM_DAFTAR(state, data) {
      state.activeDataInvoice = state.listPenjualan.find(x => x.id === data)
    },
    REMOVE_DATA_PENJUALAN(state, data) {
      const index = state.listPenjualan.findIndex(x => x.id === data)
      state.listPenjualan.splice(index, 1)
    },
    RETUR_DATA_PENJUALAN(state, data) {
      const index = state.listPenjualan.findIndex(x => x.id === data)
      const dd = state.listPenjualan[index]
      state.listPenjualan.splice(index, 1)
      state.listPenjualanRetur.push(dd, 1)
    },
  },
  actions: {
    addTransaksi(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}penjualan/store`, data)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    editTransaksi(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .put(`${axios.defaults.baseURL}penjualan/edit/${data.id}`, data)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    deleteTransaksi(ctx, { id }) {
      return new Promise((resolve, reject) => {
        axios
          .delete(`${axios.defaults.baseURL}penjualan/delete/${id}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    returTransaksi(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}penjualan/retur`, data)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    fetchListTransaksiPenjualan(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}penjualan/cabang/${params.cabang}/awal/${params.dateawal}/akhir/${params.dateakhir}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchListTransaksiByBarang(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}penjualan/detail/barang/${params.kodeBarang}/cabang/${params.cabang}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchDataBank(ctx, queryParams) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}bank/`, {
            params: queryParams,
          })
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    storePiutang(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}pembayaran/store/piutang`, data)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
  },
}
