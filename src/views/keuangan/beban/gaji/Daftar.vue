<template>
  <section>
    <b-row class="match-height">
      <!-- <b-col lg="6" cols="6">
        <b-card title="Form Penggajian"> </b-card>
      </b-col> -->
      <b-col lg="6" cols="12">
        <b-card title="Summary Beban Gaji">
          <b-row>
            <b-col lg="12" cols="12">
              <b-form-group label="Tahun Buku" label-cols-md="3">
                <v-select :options="option" v-model="tahun" :clearable="false" />
              </b-form-group>
              <b-form-group label="Kode Akun" label-cols-md="3">
                <b-form-input v-model="dataMaster.kode_akun" readonly />
              </b-form-group>
              <b-form-group label="Nama Akun" label-cols-md="3">
                <b-form-input v-model="dataMaster.nama" readonly />
              </b-form-group>
              <b-form-group label="Saldo Akun" label-cols-md="3">
                <b-form-input :value="formatRupiah(dataMaster.saldo)" readonly />
              </b-form-group>
              <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" type="button" @click="tambah" variant="primary" class="mr-1">
                Tambah
              </b-button>
            </b-col>
          </b-row>
        </b-card>
      </b-col>

      <b-col lg="12" cols="12">
        <b-card>
          <detail-table @destroy="destroyId" :data-list="dataDetail" />
        </b-card>
      </b-col>
    </b-row>

    <b-modal ref="modal-gaji" ok-variant="success" ok-title="Submit" modal-class="modal-success" centered title="Form Data Penggajian" @ok="submit">
      <b-row>
        <b-col lg="12" cols="12">
          <b-form-group label="Tanggal Gaji" label-for="tanggal" label-cols-md="4">
            <b-form-datepicker v-model="formGaji.tanggalGaji" locale="id" />
          </b-form-group>
          <b-form-group label="Kategori Gaji" label-for="tipe" label-cols-md="4">
            <v-select v-model="formGaji.kategori" :clearable="false" placeholder="Kategori Gaji" label="nama" :options="kategoriGaji" />
          </b-form-group>

          <b-form-group label="Uang Makan" label-for="tipe" label-cols-md="4">
            <v-select placeholder="Uang Makan" v-model="formGaji.uang_makan" label="nama" :clearable="false" :options="kategoriBonus" />
          </b-form-group>

          <b-form-group label="Bonus" label-for="tipe" label-cols-md="4">
            <v-select placeholder="Bonus" v-model="formGaji.bonus" label="nama" :clearable="false" :options="kategoriBonus" />
          </b-form-group>

          <b-form-group label="Berdasarkan" label-for="tipe" label-cols-md="4">
            <v-select v-model="formGaji.absensi" :clearable="false" label="nama" :options="absensiOptions" />
            <small class="mt-1 text-danger"> {{ alertText }}</small>
          </b-form-group>

          <b-form-group label="Tanggal Absensi" label-for="tipe" label-cols-md="4" v-if="formGaji.absensi.value === 1 ? true : false">
            <b-form-datepicker v-model="formGaji.tanggalAbsensi" locale="id" />
          </b-form-group>

          <b-form-group label="Catatan" label-for="catatan" label-cols-md="4">
            <b-form-textarea placeholder="Catatan" type="text" v-model="formGaji.catatan" />
          </b-form-group>
        </b-col>
      </b-row>
    </b-modal>
  </section>
</template>

<script>
import store from '@/store'
import router from '@/router'

import {
  BCard,
  // BTab,
  // BTabs,
  BModal,
  VBModal,
  BFormDatepicker,
  BFormGroup,
  BRow,
  BCol,
  BFormInput,
  BButton,
  BFormTextarea,
} from 'bootstrap-vue'
import Ripple from 'vue-ripple-directive'
import vSelect from 'vue-select'
// import MasterTable from './component/MasterTable.vue'
import DetailTable from './component/DetailTable.vue'

export default {
  components: {
    vSelect,
    // BTab,
    // BTabs,
    BFormDatepicker,
    BButton,
    BCard,
    BRow,
    BCol,
    BFormInput,
    BFormGroup,
    BFormTextarea,
    // MasterTable,
    DetailTable,
    BModal,
  },
  directives: {
    Ripple,
    'b-modal': VBModal,
  },
  data() {
    return {
      tahun: '2021',
      option: ['2021', '2022', '2023'],
      alertText: 'Data akan di tarik berdasarkan absensi',
      absensiOptions: [
        {
          nama: 'ABSENSI',
          value: 1,
        },
        {
          nama: 'SEMUA PEGAWAI',
          value: 2,
        },
        {
          nama: 'MANUAL',
          value: 3,
        },
      ],
      kategoriGaji: [
        {
          nama: 'HARIAN',
          value: 1,
        },
        {
          nama: 'MINGGUAN',
          value: 2,
        },
        {
          nama: 'BULANAN',
          value: 3,
        },
        {
          nama: 'LEMBUR',
          value: 4,
        },
      ],
      kategoriBonus: [
        {
          nama: 'DIBAYARKAN',
          value: 1,
        },
        {
          nama: 'TIDAK DIBAYARKAN',
          value: 2,
        },
      ],
      formGaji: {
        absensi: {
          nama: 'ABSENSI',
          value: 1,
        },
        kategori: {
          nama: 'HARIAN',
          value: 1,
        },
        uang_makan: {
          nama: 'DIBAYARKAN',
          value: 1,
        },
        bonus: {
          nama: 'TIDAK DIBAYARKAN',
          value: 2,
        },
        catatan: '',
        tanggalGaji: '',
        tanggalAbsensi: '',
      },
      dataDetail: [],
      dataMaster: {
        saldo: 0,
      },
    }
  },
  watch: {
    formGaji: {
      deep: true,
      handler(x) {
        this.alertText = `Data akan di tarik berdasarkan absensi tanggal ${this.$moment(this.formGaji.tanggalAbsensi).format('DD MMM YYYY')}`
        if (x.absensi.value === 2) {
          this.alertText = 'Data berdasarkan seluruh pegawai'
        } else if (x.absensi.value === 3) {
          this.alertText = 'Pegawai akan di pilih secara manual'
        }
      },
    },
    tahun(x) {
      this.loadMaster(x)
    },
  },
  mounted() {
    this.loadMaster()
  },
  methods: {
    tambah() {
      this.$refs['modal-gaji'].show()
    },
    cekValidasiForm() {
      if (this.formGaji.tanggalGaji === null || this.formGaji.tanggalGaji === '') {
        this.error('Tanggal Gaji')
        return false
      }
      if (this.formGaji.absensi.value === 1) {
        if (this.formGaji.tanggalAbsensi === null || this.formGaji.tanggalAbsensi === '') {
          this.error('Tanggal Absensi')

          return false
        }
      }

      return true
    },
    error(title) {
      this.$swal({
        title: 'Error!',
        text: `${title} belum diisi !!`,
        icon: 'error',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
    },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
    submit() {
      if (this.cekValidasiForm() === true) {
        const loader = this.$loading.show({})
        const user = JSON.parse(localStorage.getItem('userData'))
        store
          .dispatch('app-pegawai/tarikDataPegawaiGaji', {
            kategori: this.formGaji.kategori.value,
            absensi: this.formGaji.absensi.value,
            bonus: this.formGaji.bonus.value,
            tanggal: this.formGaji.absensi.value === 1 ? this.formGaji.tanggalAbsensi : null,
            cabang_id: user.cabang_id,
          })
          .then(res => {
            loader.hide()
            if (res.status === 200) {
              store.commit('app-keuangan/SET_DATA_DETAIL_PENGGAJIAN', res.data)
              router.push({ name: 'beban-gaji-tambah-detail', params: { form: this.formGaji, data: res.data } })
            }
          })
      }
    },
    destroyId(data) {
      const { id } = data.item
      this.$swal({
        title: 'Delete data ?',
        text: 'Data gaji akan di hapus',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Ya!',
        customClass: {
          confirmButton: 'btn btn-primary',
          cancelButton: 'btn btn-outline-danger ml-1',
        },
        buttonsStyling: false,
      }).then(result => {
        if (result.value) {
          store.dispatch('app-keuangan/removeGaji', id).then(x => {
            if (x.status === 200) {
              store.commit('app-keuangan/REMOVE_DETAIL_PENGGAJIAN', id)
              store.dispatch('app-keuangan/removeJurnal', x.data.nomor_jurnal).then(d => {
                if (d.status === 200) {
                  this.$swal({
                    icon: 'success',
                    title: 'Deleted!',
                    customClass: {
                      confirmButton: 'btn btn-success',
                    },
                  })
                } else {
                  this.$swal({
                    icon: 'error',
                    title: 'Oopps!! Kesalahan',
                    customClass: {
                      confirmButton: 'btn btn-success',
                    },
                  })
                }
              })
            } else {
              this.$swal({
                icon: 'error',
                title: 'Oopps!! Kesalahan',
                customClass: {
                  confirmButton: 'btn btn-success',
                },
              })
            }
          })
        }
      })
    },
    loadMaster(x = null) {
      let tahun = x
      if (x === null) {
        const d = new Date()
        tahun = d.getFullYear()
      }
      const user = JSON.parse(localStorage.getItem('userData'))
      const cabang = user.cabang_id
      store
        .dispatch('app-keuangan/fetchGaji', {
          tahun,
          cabang,
        })
        .then(res => {
          store.commit('app-keuangan/SET_DATA_BEBAN_GAJI', res.data)
          this.dataMaster = store.getters['app-keuangan/getDataBebanGaji']
        })
      store
        .dispatch('app-keuangan/fetchMasterGaji', {
          tahun,
          cabang,
        })
        .then(res => {
          store.commit('app-keuangan/SET_DATA_MASTER_PENGGAJIAN', res.data)
          this.dataDetail = store.getters['app-keuangan/getMasterPenggajian']
        })
    },
  },
}
</script>
<style lang="scss" scoped>
@import '@core/scss/vue/libs/vue-flatpicker.scss';
@import '@core/scss/vue/libs/vue-select.scss';
.per-page-selector {
  width: 90px;
}
</style>
