<template>
  <section>
    <div ref="container">
      <b-row>
        <b-col lg="3" cols="12">
          <b-card title="Lucky Anggara" sub-title="IT Support">
            <b-img fluid class="mb-2" :src="require('@/assets/images/slider/06.jpg')" />
            <b-button v-ripple.400="'rgba(113, 102, 240, 0.15)'" variant="outline-danger" @click="uploadFoto()">
              Upload Foto
            </b-button>
          </b-card>
        </b-col>
        <b-col lg="9" cols="12">
          <b-card>
            <b-col lg="9" cols="12">
              <div class="mt-2">
                <table class="mt-xl-0 w-100">
                  <tr>
                    <th class="pb-50">
                      <span class="font-weight-bold">Nomor KTP</span>
                    </th>
                    <td class="pb-50">
                      <b-form-input v-model="dataPegawai.ktp" />
                    </td>
                  </tr>
                  <tr>
                    <th class="pb-50">
                      <span class="font-weight-bold">Nama Lengkap</span>
                    </th>
                    <td class="pb-50">
                      <b-form-input v-model="dataPegawai.nama" />
                    </td>
                  </tr>
                  <tr>
                    <th class="pb-50">
                      <span class="font-weight-bold">Jenis Kelamin</span>
                    </th>
                    <td class="pb-50">
                      <v-select
                        v-model="dataPegawai.jenis_kelamin"
                        :value="dataPegawai.jenis_kelamin"
                        :options="jenisKelaminOptions"
                        :clearable="false"
                        class="per-page-selector d-inline-block mr-1"
                      />
                    </td>
                  </tr>
                  <tr>
                    <th class="pb-50">
                      <span class="font-weight-bold">Tanggal Lahir</span>
                    </th>
                    <td class="pb-50">
                      <flat-pickr v-model="dataPegawai.tanggal_lahir" class="form-control" :config="date.config" />
                    </td>
                  </tr>
                  <tr>
                    <th class="pb-50">
                      <span class="font-weight-bold">Pendidikan Terakhir</span>
                    </th>
                    <td class="pb-50">
                      <v-select
                        v-model="dataPegawai.pendidikan_terakhir"
                        :value="dataPegawai.pendidikan_terakhir"
                        :options="pendidikanOptions"
                        :clearable="false"
                        class="per-page-selector d-inline-block mr-1"
                      />
                    </td>
                  </tr>
                  <hr />
                  <tr>
                    <th class="pb-50">
                      <span class="font-weight-bold">Alamat</span>
                    </th>
                    <td class="pb-50">
                      <b-form-input v-model="dataPegawai.alamat" />
                    </td>
                  </tr>
                  <tr>
                    <th class="pb-50">
                      <span class="font-weight-bold">Kecamatan</span>
                    </th>
                    <td class="pb-50">
                      <b-form-input v-model="dataPegawai.kecamatan" />
                    </td>
                  </tr>
                  <tr>
                    <th class="pb-50">
                      <span class="font-weight-bold">Kelurahan</span>
                    </th>
                    <td class="pb-50">
                      <b-form-input v-model="dataPegawai.kelurahan" />
                    </td>
                  </tr>
                  <tr>
                    <th class="pb-50">
                      <span class="font-weight-bold">Kota</span>
                    </th>
                    <td class="pb-50">
                      <b-form-input v-model="dataPegawai.kota" />
                    </td>
                  </tr>
                  <hr />
                  <tr>
                    <th class="pb-50">
                      <span class="font-weight-bold">Nomor Telepon</span>
                    </th>
                    <td class="pb-50">
                      <b-form-input v-model="dataPegawai.nomor_telepon" />
                    </td>
                  </tr>
                  <tr>
                    <th class="pb-50">
                      <span class="font-weight-bold">Nomor Rekening</span>
                    </th>
                    <td class="pb-50">
                      <b-form-input v-model="dataPegawai.nomor_rekening" />
                    </td>
                  </tr>
                  <tr>
                    <th class="pb-50">
                      <span class="font-weight-bold">Nomor Pokok Wajib Pajak</span>
                    </th>
                    <td class="pb-50">
                      <b-form-input v-model="dataPegawai.npwp" />
                    </td>
                  </tr>
                  <hr />
                  <tr>
                    <th>
                      <!-- <feather-icon icon="PhoneIcon" class="mr-75" /> -->
                      <span class="font-weight-bold">Tanggal Mulai Bekerja</span>
                    </th>
                    <td class="pb-50">
                      <flat-pickr v-model="dataPegawai.tanggal_masuk" class="form-control" :config="date.config" />
                    </td>
                  </tr>
                  <tr>
                    <th>
                      <!-- <feather-icon icon="PhoneIcon" class="mr-75" /> -->
                      <span class="font-weight-bold">Penempatan</span>
                    </th>
                    <td class="pb-50">
                      <v-select
                        v-model="dataPegawai.cabang_id"
                        :value="dataPegawai.cabang_id"
                        :options="cabangOptions"
                        label="nama"
                        :reduce="cabang => cabang.id"
                        :clearable="false"
                        class="per-page-selector d-inline-block mr-1"
                      />
                    </td>
                  </tr>
                  <tr>
                    <th>
                      <!-- <feather-icon icon="PhoneIcon" class="mr-75" /> -->
                      <span class="font-weight-bold">Divisi</span>
                    </th>
                    <td class="pb-50">
                      <v-select
                        v-model="dataPegawai.divisi_id"
                        :value="dataPegawai.divisi_id"
                        :options="divisiOptions"
                        label="nama"
                        :reduce="divisi => divisi.id"
                        :clearable="false"
                        class="per-page-selector d-inline-block mr-1"
                      />
                    </td>
                  </tr>
                  <tr>
                    <th>
                      <!-- <feather-icon icon="PhoneIcon" class="mr-75" /> -->
                      <span class="font-weight-bold">Jabatan</span>
                    </th>
                    <td class="pb-50">
                      <v-select
                        v-model="dataPegawai.jabatan_id"
                        :value="dataPegawai.jabatan_id"
                        :options="jabatanOptions"
                        label="nama"
                        :reduce="jabatan => jabatan.id"
                        :clearable="false"
                        class="per-page-selector d-inline-block mr-1"
                      />
                    </td>
                  </tr>
                </table>
              </div>
            </b-col>
          </b-card>
        </b-col>
      </b-row>
    </div>
    <b-modal ref="upload-modal" title="Upload Foto" centered no-close-on-backdrop no-close-on-esc ok-only ok-title="Close" size="md">
      <vue-dropzone
        ref="myVueDropzone"
        v-on:vdropzone-sending="sendingEvent"
        v-on:vdropzone-success="sendingSuccess"
        id="dropzone"
        :options="dropzoneOptions"
      ></vue-dropzone>
    </b-modal>
  </section>
</template>

<script>
import store from '@/store'
import { ref } from '@vue/composition-api'

import { BButton, BImg, BRow, BCol, BFormInput, BCard, BModal, VBModal } from 'bootstrap-vue'
import Ripple from 'vue-ripple-directive'
import vSelect from 'vue-select'
import flatPickr from 'vue-flatpickr-component'
import vue2Dropzone from 'vue2-dropzone'
import 'vue2-dropzone/dist/vue2Dropzone.min.css'

export default {
  components: {
    vueDropzone: vue2Dropzone,
    BModal,
    BFormInput,
    vSelect,
    flatPickr,
    BButton,
    BImg,
    BRow,
    BCol,
    BCard,
  },
  directives: {
    'b-modal': VBModal,
    Ripple,
  },
  data() {
    return {
      dropzoneOptions: {
        url: 'http://127.0.0.1:8000/api/rkt/upload',
        thumbnailWidth: 200,
        addRemoveLinks: true,
      },
      dataPegawai: {
        ktp: '',
        nama: '',
        jenis_kelamin: '',
        tanggal_lahir: '',
        pendidikan_terakhir: '',
        alamat: '',
        kecamatan: '',
        kelurahan: '',
        kota: '',
        nomor_rekening: '',
        npwp: '',
        tanggal_masuk: '',
        cabang_id: '',
        divisi_id: '',
        jabatan_id: '',
      },
      date: {
        config: {
          wrap: true, // set wrap to true only when using 'input-group'
          altFormat: 'd F Y',
          altInput: true,
          dateFormat: 'Y-m-d',
        },
      },
    }
  },
  methods: {
    uploadFoto() {
      this.$refs['upload-modal'].show()
    },
    simpan() {
      this.$swal({
        title: 'Simpan Data',
        text: 'Apa anda yakin ?',
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
          store.dispatch('app-pegawai/addPegawai', this.dataPegawai).then(res => {
            if (res.status === 200) {
              store.commit('app-pegawai/UPDATE_DATA_LIST_PEGAWAI', res.data)
              this.$swal({
                title: 'Success!',
                text: 'Data baru tersimpan!!',
                icon: 'success',
                customClass: {
                  confirmButton: 'btn btn-primary',
                },
                buttonsStyling: false,
              })
            }
          })
        }
      })
    },
    loadDataSelect() {
      this.jabatanOptions = store.getters['app-pegawai/getListJabatan']
      this.divisiOptions = store.getters['app-pegawai/getListDivisi']
      this.cabangOptions = store.getters['app-pegawai/getListCabang']
    },
    setData() {
      store.dispatch('app-pegawai/fetchListJabatanDivisiCabang').then(res => {
        if (res.status === 200) {
          store.commit('app-pegawai/SET_LIST_JABATAN_DIVISI_CABANG', res.data)
          this.loadDataSelect()
        }
      })
    },
  },
  mounted() {
    this.setData()
  },
  setup() {
    const jabatanOptions = ref()
    const divisiOptions = ref()
    const cabangOptions = ref()
    const jenisKelaminOptions = ref(['LAKI - LAKI', 'PEREMPUAN'])
    const pendidikanOptions = ref(['SD', 'SMP', 'SMA', 'D3', 'S1', 'S2', 'S3', 'LAINNYA'])

    return {
      pendidikanOptions,
      jenisKelaminOptions,
      jabatanOptions,
      divisiOptions,
      cabangOptions,
    }
  },
}
</script>

<style lang="scss" scoped>
.per-page-selector {
  width: 100%;
}
</style>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
@import '@core/scss/vue/libs/vue-flatpicker.scss';
</style>
