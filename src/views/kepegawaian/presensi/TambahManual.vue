<template>
  <section>
    <b-row>
      <b-col lg="9" cols="12">
        <b-card title="Detail Data">
          <b-form-group label="Nama Pegawai" label-for="tipe" label-cols-md="2">
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

            <!-- Column: JAM MASUK -->
            <template #cell(jamMasuk)="data">
              <span>{{ data.item.jamMasuk !== null || data.item.jamMasuk !== '' ? data.item.jamMasuk : '-' }}</span>
            </template>

            <!-- Column: JAM KELUAR -->
            <template #cell(jamKeluar)="data">
              <span>{{ data.item.jamKeluar !== null || data.item.jamKeluar !== '' ? data.item.jamKeluar : '-' }}</span>
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
      <b-col lg="3" cols="12">
        <b-card title="Action">
          <b-button class="mt-1" variant="primary" @click="proses">
            Proses
          </b-button>
        </b-card>
      </b-col>
    </b-row>
    <b-modal ref="modal-presensi" ok-variant="success" ok-title="Submit" modal-class="modal-success" centered title="Form Presensi Manual" @ok="submit">
      <b-row>
        <b-col lg="12" cols="12">
          <b-form-group label="ID Pegawai" label-for="tipe" label-cols-md="4">
            <b-form-input v-model="pilihPegawai.id" readonly />
          </b-form-group>

          <b-form-group label="Nama Pegawai" label-for="tipe" label-cols-md="4">
            <b-form-input v-model="pilihPegawai.nama" readonly />
          </b-form-group>
          <hr />

          <b-form-group label="Tanggal" label-for="tanggal" label-cols-md="4">
            <b-form-datepicker v-model="tanggal" locale="id" />
          </b-form-group>
          <b-form-group label="Jam Masuk" label-for="tanggal" label-cols-md="4">
            <b-form-timepicker v-model="jamMasuk" locale="id" @context="onContext1" />
            <small class="text-danger">Jam Masuk adalah jam 07:00 </small>
          </b-form-group>

          <b-form-group label="Jam Keluar" label-for="tanggal" label-cols-md="4">
            <b-form-timepicker v-model="jamKeluar" locale="id" @context="onContext2" />
            <small class="text-danger">Jam Keluar adalah jam 16:00 </small>
          </b-form-group>

          <b-form-group label="Catatan" label-for="tipe" label-cols-md="4">
            <b-form-input v-model="catatan" readonly />
          </b-form-group>
        </b-col>
      </b-row>
    </b-modal>
  </section>
</template>

<script>
import store from '@/store'
import { ref } from '@vue/composition-api'
// import router from '@/router'

import { BCard, BFormDatepicker, BFormInput, BFormTimepicker, BFormGroup, BRow, BCol, BTable, BButton, VBModal } from 'bootstrap-vue'
import vSelect from 'vue-select'
// import MasterTable from './component/MasterTable.vue'

export default {
  components: {
    vSelect,
    BTable,
    BFormDatepicker,
    BFormTimepicker,
    BFormInput,
    BButton,
    BCard,
    BRow,
    BCol,
    BFormGroup,
  },
  directives: {
    'b-modal': VBModal,
  },
  data() {
    return {}
  },
  watch: {
    form: {
      deep: true,
      handler() {},
    },
  },
  mounted() {
    this.loadPegawai()
    console.info(this.tanggal)
  },
  methods: {
    /* eslint-enable */
    onContext1(ctx) {
      this.context1 = ctx
      if (this.jamMasuk === '') {
        this.catatan = ''
        return
      }
      if (this.context1.hours <= 7 && this.jamMasuk !== '') {
        if (this.context1.hours === 7 && this.context1.minutes > 0) {
          this.catatan = 'TELAT MASUK KERJA'
        } else {
          this.catatan = 'MASUK KERJA BELUM ABSEN PULANG'
        }
      } else {
        this.catatan = 'TELAT MASUK KERJA'
      }
    },
    onContext2(ctx) {
      this.context2 = ctx
      if (this.jamKeluar === '') {
        this.catatan = ''
        return
      }
      if (this.context2.hours >= 16 && this.jamKeluar !== '') {
        if (this.context1.hours <= 7 && this.jamMasuk !== '') {
          this.catatan = 'MASUK KERJA'
        }
      } else {
        this.catatan = 'MASUK KERJA, ABSEN PULANG LEBIH CEPAT'
      }
    },
    tambah() {
      if (this.pilihPegawai.id === '') {
        this.$swal({
          title: 'Error!',
          text: 'Pegawai belum di pilih',
          icon: 'error',
          customClass: {
            confirmButton: 'btn btn-primary',
          },
          buttonsStyling: false,
        })
        return
      }
      const ada = this.masterData.find(x => x.id === this.pilihPegawai.id)
      if (ada === undefined) {
        this.$refs['modal-presensi'].show()
        return
      }
      if (ada !== undefined || ada.length > 1) {
        this.$swal({
          title: 'Error!!',
          text: 'Pegawai sudah ada di daftar',
          icon: 'error',
          customClass: {
            confirmButton: 'btn btn-primary',
          },
          buttonsStyling: false,
        })
        this.reset()
        return
      }
      this.$refs['modal-presensi'].show()
    },
    reset() {
      this.tanggal = new Date()
      this.jamMasuk = ''
      this.jamKeluar = ''
      this.catatan = ''
      this.context1 = ''
      this.context2 = ''
    },
    submit() {
      const data = {
        id: this.pilihPegawai.id,
        nama: this.pilihPegawai.nama,
        jamMasuk: this.jamMasuk,
        jamKeluar: this.jamKeluar,
        catatan: this.catatan,
      }

      this.masterData.push(data)
      this.reset()
      console.info(this.masterData)
    },
    loadPegawai() {
      this.listPegawai = store.getters['app-pegawai/getListPegawai']
      if (store.getters['app-pegawai/getListPegawai'].length <= 0) {
        store.dispatch('app-pegawai/fetchListPegawai').then(res => {
          store.commit('app-pegawai/SET_LIST_PEGAWAI', res.data)
          this.listPegawai = store.getters['app-pegawai/getListPegawai']
        })
      }
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
        name: 'master-presensi',
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
      if (this.masterData.length <= 0) {
        this.$swal({
          title: 'Error!',
          text: 'Belum ada data absensi, silahkan isi dulu data absensi',
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
        text: 'Absensi manual akan di proses ??',
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
          const loader = this.$loading.show()
          loader.hide()

          store
            .dispatch('app-pegawai/storePresensiManual', {
              tanggal: this.tanggal,
              data: this.masterData,
              user,
            })
            .then(res => {
              if (res.status === 200) {
                this.success()
              } else {
                this.error(res.message)
              }
            })
        }
      })
    },
    destroyId(x) {
      this.masterData.splice(x, 1)
    },
  },
  setup() {
    const context1 = ref('')
    const context2 = ref('')
    const masterData = ref([])
    const listPegawai = ref([])
    const pilihPegawai = ref({
      id: '',
      nama: '',
    })
    const tanggal = new Date()
    const jamMasuk = ref('')
    const jamKeluar = ref('')
    const catatan = ref('')
    const tableColumns = ref([
      { key: 'no', sortable: false },
      {
        key: 'nama_pegawai',
      },
      {
        key: 'jamMasuk',
      },
      {
        key: 'jamKeluar',
      },
      {
        key: 'catatan',
      },
      {
        key: 'actions',
      },
    ])

    return {
      context1,
      context2,
      masterData,
      listPegawai,
      pilihPegawai,
      tableColumns,
      tanggal,
      jamMasuk,
      jamKeluar,
      catatan,
    }
  },
}
</script>

<style lang="scss" scoped>
@import '@core/scss/vue/libs/vue-select.scss';
</style>
