<template>
  <section>
    <b-row class="match-height">
      <b-col lg="9" cols="12">
        <b-card :title="`Detail Absen Tanggal : ${tanggal}`">
          <small v-if="sukses ? true : false">Data berhasil terupload</small>
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
            <template #cell(jam_masuk)="data">
              <b-form-timepicker v-model="data.item.jam_masuk" locale="id" />
            </template>

            <!-- Column: JAM KELUAR -->
            <template #cell(jam_keluar)="data">
              <b-form-timepicker v-model="data.item.jam_keluar" locale="id" />
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
        <b-card title="Actions">
          <h4>Upload Data</h4>

          <b-form-group label="Tanggal Absen" label-for="tanggal">
            <b-form-datepicker v-model="tanggal" locale="id" />
          </b-form-group>

          <b-form-file v-model="file" :state="Boolean(file)" placeholder="Choose a file or drop it here..." drop-placeholder="Drop file here..."></b-form-file>
          <div class="mt-1">Selected file: {{ file ? file.name : '' }}</div>
          <b-button v-if="(file === null || file === '') && (tanggal === '' || tanggal === null) ? false : true" class="mt-1" variant="primary" @click="upload">
            Upload File
          </b-button>
          <hr />
          <b-form-group v-if="file === null && (tanggal === '' || tanggal === null) ? false : true">
            <b-button class="mt-1" variant="primary" @click="update">
              Update
            </b-button>
            <br />
            <small> Tekan Update jika melakukan perubahan data</small>
          </b-form-group>
          <hr />
          <b-form-group>
            <b-button
              class="mt-1"
              variant="primary"
              @click="
                $router.push({
                  name: 'master-presensi',
                })
              "
            >
              Kembali
            </b-button>
          </b-form-group>
        </b-card>
      </b-col>
    </b-row>
  </section>
</template>

<script>
import store from '@/store'
// import router from '@/router'

import { BFormFile, BCard, BFormDatepicker, BFormTimepicker, BFormGroup, BRow, BCol, BTable, BButton } from 'bootstrap-vue'
// import vSelect from 'vue-select'
// import MasterTable from './component/MasterTable.vue'

export default {
  components: {
    BFormFile,
    // vSelect,
    BTable,
    BFormDatepicker,
    BFormTimepicker,
    BButton,
    BCard,
    BRow,
    BCol,
    BFormGroup,
  },
  data() {
    return {
      sukses: false,
      file: null,
      masterData: [],
      tanggal: '',
      tableColumns: [
        { key: 'no', sortable: false },
        {
          key: 'nama_pegawai',
        },
        {
          key: 'jam_masuk',
        },
        {
          key: 'jam_keluar',
        },
        {
          key: 'catatan',
        },
        {
          key: 'actions',
        },
      ],
    }
  },
  methods: {
    success() {
      this.$swal({
        title: 'Success!',
        text: 'Update Sukses!!',
        icon: 'success',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
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
    upload() {
      this.masterData = []
      const user = JSON.parse(localStorage.getItem('userData'))
      const loader = this.$loading.show({
        container: this.$refs.formContainer,
      })
      const data = new FormData()
      data.append('file', this.file)
      data.append('tanggal', this.tanggal)
      data.append('user_id', user.id)
      data.append('cabang_id', user.id)
      store.dispatch('app-pegawai/uploadPresensi', data).then(res => {
        if (res.status === 200) {
          this.success()
          this.sukses = true
          this.masterData = res.data.file
        } else {
          this.error(res.message)
          this.sukses = false
        }
        loader.hide()
      })
    },
    update() {
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
        title: 'Update ?',
        text: 'Absensi manual akan di update ??',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'update !!',
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
}
</script>

<style lang="scss" scoped>
@import '@core/scss/vue/libs/vue-select.scss';
</style>
