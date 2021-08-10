import axios from '@axios'

export default {
  namespaced: true,
  state: {
    detailData: {},
    detailPresensi: [],
    listDivisi: [],
    listJabatan: [],
    listCabang: [],
    listPegawai: [],
    listSales: [],
    listPresensi: [],
  },
  getters: {
    getListDivisi: state => state.listDivisi,
    getListJabatan: state => state.listJabatan,
    getListCabang: state => state.listCabang,
    getDetailData: state => state.detailData,
    getDetailPresensi: state => state.detailPresensi,
    getListPegawai: state => state.listPegawai,
    getListSales: state => state.listSales,
    getListPresensi: state => state.listPresensi,
  },
  mutations: {
    SET_LIST_JABATAN_DIVISI_CABANG(state, data) {
      state.listDivisi = data.divisi
      state.listJabatan = data.jabatan
      state.listCabang = data.cabang
    },
    SET_LIST_PEGAWAI(state, data) {
      state.listPegawai = data
      state.listSales = state.listPegawai.filter(x => x.jabatan_id === 5)
    },
    SET_LIST_PRESENSI(state, data) {
      state.listPresensi = data
    },
    SET_DETAIL_DATA(state, data) {
      const index = state.listPegawai.findIndex(x => x.id === data)
      state.detailData = state.listPegawai[index]
    },
    SET_DETAIL_PRESENSI(state, data) {
      state.detailPresensi = data
    },
    UPDATE_DATA_LIST_PEGAWAI(state, data) {
      state.listPegawai.push(data)
    },
    UPDATE_PRESENSI(state, data) {
      const b = state.listPresensi.findIndex(x => x.id === data.id)
      state.listPresensi[b].push(data)
    },
  },
  actions: {
    fetchListJabatanDivisiCabang(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}pegawai/jabatandivisicabang`, data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchListPegawai(ctx, queryParams) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}pegawai/`, {
            params: queryParams,
          })
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    editPegawai(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .put(`${axios.defaults.baseURL}pegawai/edit/${data.id}`, data.data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    addPegawai(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}pegawai/store`, data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    uploadFoto(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}pegawai/store`, data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchDetailPresensi(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}pegawai/presensi/${data.pegawai_id}/bulan/${data.bulan}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    fetchListPresensi(ctx, date) {
      return new Promise((resolve, reject) => {
        axios
          .get(`${axios.defaults.baseURL}presensi/${date}`)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    updateAbsenMasuk(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}presensi/store/update-masuk/`, data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    updateAbsenKeluar(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}presensi/store/update-keluar/`, data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    tarikDataPegawaiGaji(ctx, params) {
      return new Promise((resolve, reject) => {
        axios
          .get(
            `${axios.defaults.baseURL}gaji/pegawai?cabang_id=${params.cabang_id}&absensi=${params.absensi}&tipe=${params.kategori}&bonus=${params.bonus}&tanggal=${params.tanggal}`,
          )
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    storePresensiManual(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}presensi/store/manual`, data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
    uploadPresensi(ctx, data) {
      return new Promise((resolve, reject) => {
        axios
          .post(`${axios.defaults.baseURL}presensi/upload-file`, data)
          .then(response => {
            resolve(response)
          })
          .catch(error => reject(error))
      })
    },
  },
}
