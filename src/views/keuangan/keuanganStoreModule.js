import axios from '@axios'

export default {
  namespaced: true,
  state: {
    listJurnal: [],
    listAkun: [],
    dataLedger: [],
    dataAssets: [],
    dataLiabilities: [],
    dataEquity: [],
    dataPendapatan: [],
    dataBeban: [],
    // BEBAN
    dataBebanOperasional: {},
    // GAJI
    dataBebanGaji: {},
    listMasterPenggajian: [],
    listDataDetailPenggajian: [],
  },
  getters: {
    getListAkun: state => state.listAkun,
    getListJurnal: state => state.listJurnal,
    getDataLedger: state => state.dataLedger,
    getNeracaAssets: state => state.dataAssets,
    getNeracaLiabilities: state => state.dataLiabilities,
    getNeracaEquity: state => state.dataEquity,
    getTotalAssets: state => state.totalAssets,
    getPendapatan: state => state.dataPendapatan,
    getBeban: state => state.dataBeban,
    // BEBAN
    getDataBebanOperasional: state => state.dataBebanOperasional,
    // GAJI
    getDataBebanGaji: state => state.dataBebanGaji,
    getMasterPenggajian: state => state.listMasterPenggajian,
    getDataDetailPenggajian: state => state.listDataDetailPenggajian,
  },
  mutations: {
    SET_LIST_AKUN(state, data) {
      state.listAkun = data
    },
    SET_LIST_JURNAL(state, data) {
      state.listJurnal = data
    },
    UPDATE_LIST_JURNAL(state, data) {
      state.listJurnal.push(data)
    },
    SET_DATA_LEDGER(state, data) {
      state.dataLedger = data
    },
    // NERACA
    SET_NERACA(state, data) {
      state.dataAssets = data.assets.filter(x => x.saldo !== 0)
      state.dataLiabilities = data.liabilities.filter(x => x.saldo !== 0)
      state.dataEquity = data.equity.filter(x => x.saldo !== 0)
    },
    // LABA RUGI
    SET_LABA(state, data) {
      state.dataPendapatan = data.pendapatan.filter(x => x.saldo !== 1)
      state.dataBeban = data.beban.filter(x => x.saldo !== 1)
    },
    // BEBAN
    SET_DATA_BEBAN_OPERASIONAL(state, data) {
      state.dataBebanOperasional = data
    },
    ADD_DATA_BEBAN_OPERASIONAL(state, data) {
      state.dataBebanOperasional.detail.push(data)
    },
    ADD_DATA_KOMPONEN_BEBAN_OPERASIONAL(state, data) {
      state.dataBebanOperasional.komponen.push(data)
    },
    REMOVE_DETAIL_BEBAN_OPERASIONAL(state, data) {
      const index = state.dataBebanOperasional.detail.findIndex(x => x.id === data)
      state.dataBebanOperasional.detail.splice(index, 1)
    },
    // GAJI
    SET_DATA_BEBAN_GAJI(state, data) {
      state.dataBebanGaji = data
    },
    SET_DATA_MASTER_PENGGAJIAN(state, data) {
      state.listMasterPenggajian = data
    },
    SET_DATA_DETAIL_PENGGAJIAN(state, data) {
      state.listDataDetailPenggajian = data
    },
    REMOVE_DETAIL_PENGGAJIAN(state, data) {
      const index = state.listMasterPenggajian.findIndex(x => x.id === data)
      state.listMasterPenggajian.splice(index, 1)
    },
  },
  actions: {
    // AKUN
    storeAkun(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post('http://127.0.0.1:8080/api/akun/store', data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    // NERACA
    fetchNeraca(ctx, tahun) {
      return new Promise((resolve, reject) => {
        axios
          .get(`http://127.0.0.1:8080/api/neraca/tahun/${tahun}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchLabaRugi(ctx, tahun) {
      return new Promise((resolve, reject) => {
        axios
          .get(`http://127.0.0.1:8080/api/labarugi/tahun/${tahun}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchListAkun(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`http://127.0.0.1:8080/api/akun/tahun/${params.tahun}/cabang/${params.cabang}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchListJurnal(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`http://127.0.0.1:8080/api/jurnal/${params.cabang}/${params.dateawal}/${params.dateakhir}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchListNomorJurnal(ctx, nomorjurnal) {
      return new Promise((resolve, reject) => {
        axios
          .get(`http://127.0.0.1:8080/api/jurnal/${nomorjurnal}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchLedgerByAkun(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          // .get(`http://127.0.0.1:8080/api/ledger/${id}`)
          .get(`http://127.0.0.1:8080/api/ledger/${params.cabang}/${params.id}/${params.dateawal}/${params.dateakhir}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    storeJurnal(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post('http://127.0.0.1:8080/api/jurnal/store', data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    // KENAPA PAKE NOMOR JURNAL, KARENA JURNAL PAKETAN TIDAK SATUAN KAYA ID..
    removeJurnal(ctx, jurnal) {
      return new Promise((resolve, reject) => {
        axios
          .delete(`http://127.0.0.1:8080/api/jurnal/delete/${jurnal}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    returJurnal(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post('http://127.0.0.1:8080/api/jurnal/retur', data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },

    // BEBAN
    fetchOperasional(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`http://127.0.0.1:8080/api/beban/operasional/cabang/${params.cabang}/tahun/${params.tahun}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    storeBeban(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post('http://127.0.0.1:8080/api/beban/store', data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    removeBeban(ctx, id) {
      return new Promise((resolve, reject) => {
        axios
          .delete(`http://127.0.0.1:8080/api/beban/delete/${id}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },

    // GAJI
    fetchGaji(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`http://127.0.0.1:8080/api/beban/gaji/cabang/${params.cabang}/tahun/${params.tahun}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchMasterGaji(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}gaji/daftar/${params.cabang}/${params.tahun}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    storeGaji(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}gaji/store/`, data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    removeGaji(ctx, id) {
      return new Promise((resolve, reject) => {
        axios
          .delete(`${axios.defaults.baseURL}gaji/delete/${id}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    // KAS
    storeKas(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post('http://127.0.0.1:8080/api/kas/store', data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
  },
}
