<template>
  <section>
    <b-row class="match-height">
      <b-col lg="6" cols="6">
        <b-card title="Form Penggajian">
          <b-form-group label="Tanggal Gaji" label-for="tanggal" label-cols-md="4">
            <b-form-datepicker v-model="formGaji.tanggalGaji" locale="id" disabled />
          </b-form-group>

          <b-form-group label="Kategori Gaji" label-cols-md="4">
            <b-form-input v-model="formGaji.kategori.nama" readonly />
          </b-form-group>

          <b-form-group label="Uang Makan" label-cols-md="4">
            <b-form-input v-model="formGaji.uang_makan.nama" readonly />
          </b-form-group>

          <b-form-group label="Bonus" label-cols-md="4">
            <b-form-input v-model="formGaji.bonus.nama" readonly />
          </b-form-group>

          <b-form-group label="Berdasarkan" label-cols-md="4">
            <b-form-input v-model="formGaji.absensi.nama" readonly />
          </b-form-group>

          <b-form-group label="Tanggal Absensi" label-for="tipe" label-cols-md="4" v-if="formGaji.absensi.value === 1 ? true : false">
            <b-form-datepicker v-model="formGaji.tanggalAbsensi" locale="id" disabled />
          </b-form-group>

          <b-form-group label="Catatan" label-for="catatan" label-cols-md="4">
            <b-form-textarea placeholder="Catatan" type="text" v-model="formGaji.catatan" readonly />
          </b-form-group>
        </b-card>
      </b-col>

      <b-col lg="6" cols="6">
        <b-card title="Summary Pembayaran Gaji">
          <b-form-group label="Total Pegawai" label-for="tanggal" label-cols-md="4">
            <b-form-input :value="`${total_pegawai} Pegawai`" readonly />
          </b-form-group>
          <b-form-group label="Gaji Pokok" label-cols-md="4">
            <b-form-input :value="formatRupiah(gaji_pokok)" readonly />
          </b-form-group>

          <b-form-group label="Uang Makan" label-cols-md="4">
            <b-form-input :value="formatRupiah(uang_makan)" readonly />
          </b-form-group>

          <b-form-group label="Bonus" label-cols-md="4">
            <b-form-input :value="formatRupiah(bonus)" readonly />
          </b-form-group>
          <hr />
          <b-form-group label="Total di Bayarkan" label-cols-md="4">
            <b-form-input :value="formatRupiah(grand_total)" readonly />
          </b-form-group>

          <b-form-group label="Akun Kredit" label-for="tipe" label-cols-md="4">
            <v-select v-model="akun_kredit" :clearable="false" label="nama" :options="dataAkun" />
          </b-form-group>

          <b-button type="button" @click="proses" variant="primary" class="mr-1">
            Proses
          </b-button>
        </b-card>
      </b-col>

      <b-col lg="12" cols="12">
        <b-card title="Detail Data">
          <b-form-group label="Nama Pegawai" label-for="tipe" label-cols-md="2" v-if="formGaji.absensi.value === 3 ? true : false">
            <b-row>
              <b-col lg="6" cols="12">
                <v-select v-model="pilihPegawai" placeholder="Nama Pegawai" label="nama" :options="listPegawai" />
              </b-col>
              <b-col lg="6" cols="12">
                <b-button variant="primary" @click="tambah">
                  Tambah
                </b-button>
              </b-col>
            </b-row>
          </b-form-group>
          <b-table
            ref="refTable"
            responsive
            :fields="tableColumns"
            :items="masterData"
            v
            show-empty
            empty-text="Tarik data terlebih dahulu"
            class="position-relative"
          >
            <!-- Column: NOMOR -->
            <template #cell(no)="data">
              <span>{{ data.index + 1 }}</span>
            </template>

            <!-- Column: NAMA PEGAWAI -->
            <template #cell(nama_pegawai)="data">
              <span>{{ data.item.nama }}</span>
            </template>

            <!-- Column: GAJI -->
            <template #cell(gaji)="data">
              <b-form-input v-model="data.item.gaji_pokok" />
            </template>

            <!-- Column: UANG MAKAN -->
            <template #cell(uang_makan)="data">
              <b-form-input v-model="data.item.uang_makan" :disabled="formGaji.uang_makan.value === 2 ? true : false" />
            </template>

            <!-- Column: BONUS -->
            <template #cell(bonus)="data">
              <b-form-input v-model="data.item.bonus" :disabled="formGaji.bonus.value === 2 ? true : false" />
            </template>

            <!-- Column: BONUS -->
            <template #cell(status)="data">
              <b-form-checkbox v-model="data.item.dibayarkan">{{ data.item.dibayarkan === true ? 'dibayarkan' : 'tidak' }} </b-form-checkbox>
            </template>

            <!-- Column: Actions -->
            <template #cell(actions)="data">
              <div class="text-nowrap">
                <feather-icon icon="TrashIcon" size="16" class="mx-1" @click="destroyId(data.index)" />
              </div>
            </template>
          </b-table>
        </b-card>
      </b-col>
    </b-row>
  </section>
</template>

<script>
import store from '@/store'
import router from '@/router'

import { BFormCheckbox, BCard, BFormDatepicker, BFormGroup, BRow, BCol, BFormInput, BTable, BButton, BFormTextarea } from 'bootstrap-vue'
import vSelect from 'vue-select'
// import MasterTable from './component/MasterTable.vue'

export default {
  components: {
    BFormCheckbox,
    vSelect,
    // BTab,
    // BTabs,
    BTable,
    BFormDatepicker,
    BButton,
    BCard,
    BRow,
    BCol,
    BFormInput,
    BFormGroup,
    BFormTextarea,
    // MasterTable,
  },
  data() {
    return {
      masterData: [],
      pilihPegawai: {
        id: 0,
        nama: '',
      },
      akun_kredit: '',
      tableColumns: [
        { key: 'no', sortable: false },
        {
          key: 'nama_pegawai',
        },
        {
          key: 'jabatan',
        },
        {
          key: 'gaji',
        },
        {
          key: 'uang_makan',
        },
        {
          key: 'bonus',
        },
        {
          key: 'status',
        },
        {
          key: 'actions',
        },
      ],
      dataAkun: [],
    }
  },
  computed: {
    formGaji() {
      if (router.currentRoute.params.form === null || router.currentRoute.params.form === undefined) {
        router.push({ name: 'beban-gaji-daftar' })
      }
      return router.currentRoute.params.form
    },
    total_pegawai() {
      return this.masterData.filter(x => x.dibayarkan === true).length
    },
    gaji_pokok() {
      let total = 0
      this.masterData
        .filter(x => x.dibayarkan === true)
        .forEach(v => {
          total += parseFloat(v.gaji_pokok)
        })
      return total
    },
    uang_makan() {
      let total = 0
      this.masterData
        .filter(x => x.dibayarkan === true)
        .forEach(v => {
          total += parseFloat(v.uang_makan)
        })
      return total
    },
    bonus() {
      let total = 0
      this.masterData
        .filter(x => x.dibayarkan === true)
        .forEach(v => {
          total += parseFloat(v.bonus)
        })
      return total
    },
    grand_total() {
      let total = 0
      this.masterData
        .filter(x => x.dibayarkan === true)
        .forEach(v => {
          total += parseFloat(v.gaji_pokok) + parseFloat(v.uang_makan) + parseFloat(v.bonus)
        })
      return total
    },
    listPegawai() {
      if (this.formGaji.absensi.value !== 3) {
        return null
      }
      return router.currentRoute.params.data
    },
  },
  mounted() {
    this.loadAkun()
  },
  methods: {
    tambah() {
      const ada = this.masterData.find(x => x.id === this.pilihPegawai.id)
      if (ada === undefined) {
        this.masterData.push(this.pilihPegawai)
        return
      }
      if (ada.length > 1 || ada !== undefined) {
        this.$swal({
          title: 'Error!!',
          text: 'Pegawai sudah ada di daftar',
          icon: 'error',
          customClass: {
            confirmButton: 'btn btn-primary',
          },
          buttonsStyling: false,
        })
        return
      }

      this.masterData.push(this.pilihPegawai)
    },
    loadAkun() {
      store.dispatch('app-keuangan/fetchListAkun').then(res => {
        store.commit('app-keuangan/SET_LIST_AKUN', res.data)
        this.load(store.getters['app-keuangan/getListAkun'])
      })
      if (this.formGaji.absensi.value !== 3) {
        this.masterData = router.currentRoute.params.data
      }
    },
    load(data) {
      data.forEach(x => {
        x.subheader.forEach(y => {
          if (y.komponen.length !== 0) {
            y.komponen.forEach(a => {
              if (a.komponen === '1.1.2') {
                if (a.kode_akun !== this.dataAkun.kode_akun) {
                  this.dataAkun.push(a)
                }
              }
            })
          }
        })
      })
      return this.dataAkun
    },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
    success() {
      this.$swal({
        title: 'Success!',
        text: 'Transaksi Sukses!!',
        icon: 'success',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })

      this.$router.push({
        name: 'beban-gaji-daftar',
      })
    },
    error(error) {
      this.$swal({
        title: 'Error!',
        text: `Oopss ada Masalah!${error}`,
        icon: 'error',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
    },
    proses() {
      if (this.akun_kredit === '' || this.akun_kredit === null) {
        this.$swal({
          title: 'Error!',
          text: 'Akun kredit belum di isi',
          icon: 'error',
          customClass: {
            confirmButton: 'btn btn-primary',
          },
          buttonsStyling: false,
        })
        return
      }
      const user = JSON.parse(localStorage.getItem('userData'))
      this.$swal({
        title: 'Proses ?',
        text: 'Pembayaran gaji akan di proses',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Proses !!',
        customClass: {
          confirmButton: 'btn btn-primary',
          cancelButton: 'btn btn-outline-danger ml-1',
        },
        buttonsStyling: false,
      }).then(result => {
        if (result.value) {
          const loader = this.$loading.show({
            container: this.$refs.formContainer,
          })
          store
            .dispatch('app-keuangan/storeGaji', {
              form: this.formGaji,
              data: this.masterData,
              akun: this.akun_kredit,
              user,
              total: {
                jumlah_pegawai: this.total_pegawai,
                grand_total: this.grand_total,
              },
            })
            .then(res => {
              if (res.status === 200) {
                this.success()
              } else {
                this.error(res.message)
              }
              loader.hide()
            })
        }
      })
    },
    destroyId(x) {
      this.masterData.splice(x, 1)
    },
  },
}
</script>

<style lang="scss" scoped>
@import '@core/scss/vue/libs/vue-select.scss';
</style>
