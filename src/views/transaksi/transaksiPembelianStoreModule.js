import axios from '@axios'

export default {
  namespaced: true,
  state: {
    // PEMBELIAN
    draftPembelian: [],
    activePembelian: '',
    activeDataInvoice: '',
    activeOrder: '',
    listPembelian: [],
    listPembelianRetur: [],
    // PEMBAYARAN
    listPembayaran: [],
  },
  getters: {
    // PEMBELIAN
    getJumlahPembelian: state => state.draftPembelian.length,
    getActiveOrder: state => state.activeOrder,
    getActivePembelian: state => state.activePembelian,
    getDataInvoice: state => state.activeDataInvoice,

    // DRAFT TRANSAKSI PEMBELIAN
    getListDraftPembelian: state => state.draftPembelian,
    getDraftByID: state => nomor => state.draftPembelian.find(x => x.nomor === nomor),
    // TRANSAKSI PEMBELIAN
    getListTransaksiPembelian: state => state.listPembelian,
    getListTransaksiPembelianRetur: state => state.listPembelianRetur,
    getTransaksiByBarang: state => kodeBarang => state.listPembelian.filter(x => x.orders.kode_barang_id === kodeBarang),
    // PEMBAYARAN
    getListPembayaran: state => state.listPembayaran,
  },
  mutations: {
    // PEMBELIAN TRANSAKSI
    SET_ACTIVE_ORDER(state, data) {
      state.activeOrder = data
    },
    SET_ACTIVE_PEMBELIAN(state, data) {
      state.activePembelian = data
    },
    SET_DATA_INVOICE(state, data) {
      state.activeDataInvoice = data
    },
    SET_INVOICE(state, data) {
      state.activePembelian.invoice = data
    },
    ADD_ORDER_TO_ACTIVE_PEMBELIAN(state, data) {
      state.activePembelian.orders = data
    },
    // DATA DRAFT TRANSAKSI PEMBELIAN
    ADD_DRAFT_PEMBELIAN(state, data) {
      const exist = state.draftPembelian.find(x => x.nomor === data.nomor)
      if (exist === undefined) {
        state.draftPembelian.push(data)
      }
    },
    REMOVE_DRAFT_PEMBELIAN(state, data) {
      state.draftPembelian.splice(data, 1)
    },

    // DATA LIST TRANSAKSI PEMBELIAN
    SET_LIST_TRANSAKSI_PEMBELIAN(state, data) {
      state.listPembelian = data.filter(x => x.retur === 'Tidak')
      state.listPembelianRetur = data.filter(x => x.retur === 'Iya')
    },
    SET_DATA_INVOICE_FROM_DAFTAR(state, data) {
      state.activeDataInvoice = state.listPembelian.find(x => x.id === data)
    },
    REMOVE_DATA_PEMBELIAN(state, data) {
      const index = state.listPembelian.findIndex(x => x.id === data)
      state.listPembelian.splice(index, 1)
    },
    RETUR_DATA_PEMBELIAN(state, data) {
      const index = state.listPembelian.findIndex(x => x.id === data)
      const dd = state.listPembelian[index]
      state.listPembelian.splice(index, 1)
      state.listPembelianRetur.push(dd, 1)
    },
    // PEMBAYARAN
    UPDATE_PEMBAYARAN(state, data) {
      const a = state.activeDataInvoice.pembayaran.sisaPembayaran
      if (data.jenis === 'HAPUS') {
        state.activeDataInvoice.pembayaran.sisaPembayaran = parseFloat(a) + parseFloat(data.nominal)
      } else {
        state.activeDataInvoice.pembayaran.sisaPembayaran = parseFloat(a) - parseFloat(data.nominal)
      }
    },
    SET_LIST_PEMBAYARAN(state, data) {
      state.listPembayaran = data
    },
    UPDATE_LIST_PEMBAYARAN(state, data) {
      state.listPembayaran.push(data)
    },
    UPDATE_REMOVE_PEMBAYARAN(state, data) {
      state.listPembayaran.splice(data, 1)
    },
  },
  actions: {
    fetchTransaksi(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}pembelian/transaksi/${data}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    addTransaksi(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}pembelian/store`, data)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    deleteTransaksi(ctx, { id }) {
      return new Promise((resolve, reject) => {
        axios
          .delete(`${axios.defaults.baseURL}pembelian/delete/${id}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    returTransaksi(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}pembelian/retur`, data)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    fetchListTransaksiPembelian(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}pembelian/cabang/${params.cabang}/awal/${params.dateawal}/akhir/${params.dateakhir}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchListTransaksiByBarang(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}pembelian/detail/barang?id_barang=${params.idBarang}&cabang=${params.cabang}`)
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
    cekNomorTransaksi(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}pembelian/cek-nomor-transaksi?cabang_id=${params.cabang}&nomor_transaksi=${params.nomorTransaksi}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    storeUtang(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}pembayaran/store/utang`, data)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    deletePembayaranUtang(ctx, { id }) {
      return new Promise((resolve, reject) => {
        axios
          .delete(`${axios.defaults.baseURL}pembayaran/delete/utang/${id}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
    fetchListPembayaran(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}pembayaran/daftar/utang/${data}`)
          .then(response => resolve(response))
          .catch(error => reject(error))
      })
    },
  },
}
