<template>
  <section>
    <b-row class="match-height">
      <b-col lg="8" cols="8" sm="12">
        <b-card>
          <h5>Form Jurnal</h5>
          <hr />
          <b-form-group label="Jenis" label-for="jenis" label-cols-md="4">
            <v-select v-model="jenis" placeholder="Jenis" label="title" :clearable="true" :options="debitKredit" />
          </b-form-group>
          <b-form-group label="Nama Akun" label-for="nama-akun" label-cols-md="4">
            <v-select v-model="akun" placeholder="Nama Akun" label="nama" :clearable="true" :options="dataAkun" :selectable="option => option.sub_header !== 1">
              <template v-slot:option="option">
                {{ option.kode_akun }} - <b>{{ option.nama }}</b>
              </template>
            </v-select>
          </b-form-group>
          <b-form-group label="Saldo" label-for="saldo-debit" label-cols-md="4">
            <b-form-input placeholder="Saldo" v-model="saldo" type="number" />
          </b-form-group>
          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" type="button" @click="submit" variant="primary" class="mr-1">
            Submit
          </b-button>
        </b-card>
      </b-col>
      <b-col lg="6" cols="6"> </b-col>
    </b-row>
    <b-row class="match-height">
      <b-col lg="9" cols="9">
        <b-card>
          <h5>Jurnal</h5>
          <hr />
          <div class="mb-2">
            <b-table
              responsive
              primary-key="id"
              :fields="tableColumns"
              show-empty
              empty-text="Tidak ada data"
              :items="dataJurnal"
              class="position-relative"
              foot-clone
            >
              <!-- Column: Id -->
              <template #cell(id)="data">
                <span>
                  {{ data.index + 1 }}
                </span>
              </template>
              <template #cell(debit)="data">
                <span class="text-nowrap">
                  {{ data.item.jenis === 0 ? formatRupiah(data.item.saldo) : formatRupiah(0) }}
                </span>
              </template>
              <template #cell(kredit)="data">
                <span class="text-nowrap">
                  {{ data.item.jenis === 1 ? formatRupiah(data.item.saldo) : formatRupiah(0) }}
                </span>
              </template>
              <!-- Column: Actions -->
              <template #cell(actions)="data">
                <div class="text-nowrap">
                  <feather-icon icon="TrashIcon" size="16" class="mx-1" @click="remove(data.index)" />
                </div>
              </template>
              <!-- FOOTER -->

              <!-- Debit -->
              <template #foot(namaAkun)>
                <span>Total</span>
              </template>
              <template #foot(debit)>
                <span class="text-success">{{ formatRupiah(totalDebit) }}</span>
              </template>
              <template #foot(kredit)>
                <span class="text-danger">{{ formatRupiah(totalKredit) }}</span>
              </template>
              <template #foot(actions)>
                <span class="text-primary">{{ balance }}</span>
              </template>
            </b-table>
          </div>
          <b-form-group label="Tanggal Transaksi" label-for="tanggalTransaksi" label-cols-md="4">
            <flat-pickr v-model="tanggalTransaksi.value" class="form-control" :config="tanggalTransaksi.config" placeholder="Tanggal Transaksi" />
          </b-form-group>
          <b-form-group label="Catatan" label-cols-md="4">
            <b-form-textarea placeholder="Contoh : Transaksi Pembelian Mobil" v-model="catatan" />
          </b-form-group>
          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" type="button" @click="proses" variant="primary" class="mr-1">
            Proses
          </b-button>
        </b-card>
      </b-col>
    </b-row>
  </section>
</template>

<script>
import store from '@/store'
import { ref } from '@vue/composition-api'

import { BCard, BButton, BFormInput, BFormTextarea, BFormGroup, BRow, BCol, BTable } from 'bootstrap-vue'
import vSelect from 'vue-select'
import Ripple from 'vue-ripple-directive'
import flatPickr from 'vue-flatpickr-component'

export default {
  components: {
    flatPickr,
    BFormTextarea,
    BButton,
    BTable,
    vSelect,
    BFormInput,
    BCard,
    BRow,
    BCol,
    BFormGroup,
  },
  directives: {
    Ripple,
  },
  data() {
    return {
      tanggalTransaksi: {
        value: Date.now(),
        config: {
          wrap: true, // set wrap to true only when using 'input-group'
          altFormat: 'd F Y',
          altInput: true,
          dateFormat: 'Y-m-d',
        },
      },
      jenis: '',
      saldo: 0,
      akun: '',
      catatan: '',
    }
  },
  mounted() {
    this.loadAkun()
  },
  computed: {
    totalDebit() {
      let saldo = 0
      this.dataJurnal.forEach(x => {
        if (x.jenis === 0) {
          saldo += parseFloat(x.saldo)
        }
      })
      return saldo
    },
    totalKredit() {
      let saldo = 0
      this.dataJurnal.forEach(x => {
        if (x.jenis === 1) {
          saldo += parseFloat(x.saldo)
        }
      })
      return saldo
    },
    balance() {
      if (this.totalKredit === this.totalDebit) {
        return 'BALANCE'
      }
      return 'TIDAK BALANCE'
    },
  },
  methods: {
    success() {
      this.$swal({
        title: 'Success!',
        text: 'Jurnal berhasil di buat!!',
        icon: 'success',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
    },
    error() {
      this.$swal({
        title: 'Error!',
        text: 'Oopss ada masalah !!',
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
    cek() {
      if (this.jenis === '' || this.saldo === 0 || this.saldo === '' || this.akun === '') {
        return false
      }
      return true
    },
    clear() {
      this.jenis = ''
      this.akun = ''
      this.saldo = 0
    },
    submit() {
      if (this.cek()) {
        const data = {
          akunId: this.akun.id,
          namaAkun: this.akun.nama,
          kodeAkun: this.akun.kode_akun,
          jenis: this.jenis.value,
          namaJenis: this.jenis.title,
          saldo: this.saldo,
          catatan: '',
        }
        this.dataJurnal.push(data)
        this.clear()
      } else {
        this.$swal({
          icon: 'error',
          title: 'Oopss cek kembali Jurnal',
          customClass: {
            confirmButton: 'btn btn-success',
          },
        })
      }
    },
    cekValidasi() {
      if (this.tanggalTransaksi === '' || this.tanggalTransaksi === null) {
        this.$swal({
          icon: 'error',
          title: 'Tanggal transaksi belum di isi',
          customClass: {
            confirmButton: 'btn btn-success',
          },
        })
        return false
      }
      if (this.catatan === '' || this.catatan === null) {
        this.$swal({
          icon: 'error',
          title: 'Catatan wajib di isi',
          customClass: {
            confirmButton: 'btn btn-success',
          },
        })
        return false
      }
      if (this.dataJurnal.length <= 0) {
        this.$swal({
          icon: 'error',
          title: 'Oopss Data Jurnal masih Kosong',
          customClass: {
            confirmButton: 'btn btn-success',
          },
        })
        return false
      }
      if (this.balance === 'TIDAK BALANCE') {
        this.$swal({
          icon: 'error',
          title: 'Oopss Jurnal tidak Balance',
          customClass: {
            confirmButton: 'btn btn-success',
          },
        })
        return false
      }
      return true
    },
    proses() {
      if (this.cekValidasi()) {
        this.$swal({
          title: 'Proses ?',
          text: 'Data akan di proses',
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

              // Optional parameters
            })
            const output = {
              catatan: this.catatan,
              tanggalTransaksi: this.$moment(this.tanggalTransaksi.value),
              jurnal: this.dataJurnal,
              user_id: this.userData.id,
              cabang_id: this.userData.cabang_id,
            }
            store.dispatch('app-keuangan/storeJurnal', output).then(res => {
              loader.hide()
              if (res.status === 200) {
                store.commit('app-keuangan/UPDATE_LIST_JURNAL', res.data)
                this.success()
                this.$router.push({
                  name: 'akuntansi-jurnal-daftar',
                })
              } else {
                this.error()
              }
            })
          }
        })
      }
      return false
    },
    remove(x) {
      this.dataJurnal.splice(x, 1)
      this.total()
    },
    loadAkun() {
      store
        .dispatch('app-keuangan/fetchListAkun', {
          tahun: '',
          cabang_id: this.userData.cabang_id,
        })
        .then(res => {
          store.commit('app-keuangan/SET_LIST_AKUN', res.data)
          this.load(store.getters['app-keuangan/getListAkun'])
        })
    },
    load(data) {
      data.forEach(x => {
        x.subheader.forEach(y => {
          this.dataAkun.push(y)
          if (y.komponen.length !== 0) {
            y.komponen.forEach(a => {
              this.dataAkun.push(a)
            })
          }
        })
      })
      return this.dataAkun
    },
  },
  setup() {
    const userData = JSON.parse(localStorage.getItem('userData'))
    console.info(userData)
    const tableColumns = [
      { label: 'No', key: 'id', sortable: false },
      { key: 'kodeAkun', sortable: false },
      { key: 'namaAkun', sortable: false },
      { key: 'debit', sortable: false },
      { key: 'kredit', sortable: false },
      { key: 'actions', sortable: false },
    ]
    const dataAkun = ref([])
    const dataJurnal = ref([])
    const debitKredit = [
      {
        title: 'DEBIT',
        value: 0,
      },
      {
        title: 'KREDIT',
        value: 1,
      },
    ]
    return {
      userData,
      dataJurnal,
      tableColumns,
      debitKredit,
      dataAkun,
    }
  },
}
</script>

<style lang="scss" scoped>
.per-page-selector {
  width: 90px;
}
</style>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
@import '@core/scss/vue/libs/vue-flatpicker.scss';
</style>
