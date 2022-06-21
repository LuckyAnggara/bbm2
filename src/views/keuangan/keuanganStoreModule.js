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
    // UTANG
    listUtang: [],
    listUtangPo: [],
    listPiutang: [],
    // SETOR
    listSetorCabang: [],
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
    // UTANG
    getListUtang: state => state.listUtang,
    getListPiutang: state => state.listPiutang,
    getListUtangPo: state => state.listUtangPo,
    // SETOR
    getListSetorCabang: state => state.listSetorCabang,
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
    // UTANG
    SET_DATA_UTANG(state, data) {
      state.listUtang = data
    },
    SET_DATA_UTANG_PO(state, data) {
      state.listUtangPo = data
    },
    SET_DATA_PIUTANG(state, data) {
      state.listPiutang = data
    },
    // SETOR
    SET_LIST_SETOR_CABANG(state, data) {
      state.listSetorCabang = data
    },
  },
  actions: {
    // AKUN
    storeAkun(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.keuanganURL}akun/store`, data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    // NERACA
    fetchNeraca(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.keuanganURL}neraca?cabang_id=${data.cabang_id}&tahun=${data.tahun}&bulan=${data.bulan}&hari=${data.hari}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchLabaRugi(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.keuanganURL}labarugi?cabang_id=${data.cabang_id}&tahun=${data.tahun}&bulan=${data.bulan}&hari=${data.hari}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchListAkun(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.keuanganURL}akun?cabang_id=${params.cabang_id}&tahun=${params.tahun}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchListJurnal(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.keuanganURL}jurnal/${params.cabang}/${params.dateawal}/${params.dateakhir}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchListNomorJurnal(ctx, nomorjurnal) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.keuanganURL}jurnal/${nomorjurnal}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchLedgerByAkun(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.keuanganURL}ledger?cabang_id=${params.cabang_id}&akun_id=${params.id}&dd=${params.dateawal}&ddd=${params.dateakhir}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchSaldoAkun(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.keuanganURL}ledger/saldo?cabang_id=${params.cabang_id}&akun_id=${params.akun_id}&tahun=${params.tahun}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    storeJurnal(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.keuanganURL}jurnal/store`, data)
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
          .delete(`${axios.defaults.keuanganURL}jurnal/delete/${jurnal}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    returJurnal(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.keuanganURL}jurnal/retur`, data)
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
          .get(`${axios.defaults.keuanganURL}beban/operasional/cabang/${params.cabang}/tahun/${params.tahun}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    storeBeban(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.keuanganURL}beban/store`, data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    removeBeban(ctx, id) {
      return new Promise((resolve, reject) => {
        axios
          .delete(`${axios.defaults.keuanganURL}beban/delete/${id}`)
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
          .get(`${axios.defaults.keuanganURL}beban/gaji/cabang/${params.cabang}/tahun/${params.tahun}`)
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
          .post(`${axios.defaults.keuanganURL}kas/store`, data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchListSetorCabang(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(
            `${axios.defaults.baseURL}setor?jenis=${params.jenis}&cabang_id=${params.cabang}&tanggal_awal=${params.dateawal}&tanggal_akhir=${params.dateakhir}`,
          )
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    storeKasCabang(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}setor/store/`, data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    kasCabangConfirm(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}setor/confirm/`, data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    batalSetor(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}setor/batal?id=${params.id}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    // UTANGPIUTANG
    getPiutang(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}utang-piutang/get-piutang?cabang=${params.cabang}&dd=${params.dd}&ddd=${params.ddd}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    getUtang(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}utang-piutang/get-utang?cabang=${params.cabang}&dd=${params.dd}&ddd=${params.ddd}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    getUtangPo(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}utang-piutang/get-utang-po?cabang=${params.cabang}&dd=${params.dd}&ddd=${params.ddd}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    storeBatchPiutang(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}utang-piutang/store-piutang/`, data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    storeBatchUtang(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}utang-piutang/store-utang/`, data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    getListPelanggan(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}utang-piutang/get-list-pelanggan?cabang=${params.cabang}&dd=${params.dd}&ddd=${params.ddd}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    getListSupplier(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}utang-piutang/get-list-supplier?cabang=${params.cabang}&dd=${params.dd}&ddd=${params.ddd}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
  },
}
