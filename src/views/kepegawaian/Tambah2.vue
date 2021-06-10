<template>
  <section>
    <div ref="container">
      <b-row>
        <b-col lg="6" cols="12">
          <b-card>
            <b-col lg="12" cols="12">
              <div class="mt-2">
                <b-form @submit="onSubmit" @reset="onReset">
                  <b-col cols="12">
                    <b-form-group label="Nomor KTP" label-cols-md="4">
                      <b-form-input v-model="dataPegawai.ktp" />
                    </b-form-group>
                  </b-col>
                  <b-form-group label="Nama Lengkap" label-cols-md="4">
                    <b-form-input v-model="dataPegawai.nama" />
                  </b-form-group>
                  <b-form-group label="Jenis Kelamin" label-cols-md="4">
                    <v-select
                      v-model="dataPegawai.jenis_kelamin"
                      :value="dataPegawai.jenis_kelamin"
                      :options="jenisKelaminOptions"
                      :clearable="false"
                      class="per-page-selector d-inline-block mr-1"
                    />
                  </b-form-group>
                  <b-form-group label="Tanggal Lahir" label-cols-md="4">
                    <flat-pickr v-model="dataPegawai.tanggal_lahir" class="form-control" :config="date.config" />
                  </b-form-group>
                  <b-form-group label="Pendidikan Terkahir" label-cols-md="4">
                    <v-select
                      v-model="dataPegawai.pendidikan_terakhir"
                      :value="dataPegawai.pendidikan_terakhir"
                      :options="pendidikanOptions"
                      :clearable="false"
                      class="per-page-selector d-inline-block mr-1"
                    />
                  </b-form-group>
                  <hr />
                  <b-form-group label="Alamat" label-cols-md="4">
                    <b-form-input v-model="dataPegawai.alamat" />
                  </b-form-group>
                  <b-form-group label="Kecamatan" label-cols-md="4">
                    <b-form-input v-model="dataPegawai.kecamatan" />
                  </b-form-group>
                  <b-form-group label="Kelurahan" label-cols-md="4">
                    <b-form-input v-model="dataPegawai.kelurahan" />
                  </b-form-group>
                  <b-form-group label="kota" label-cols-md="4">
                    <b-form-input v-model="dataPegawai.kota" />
                  </b-form-group>
                  <hr />
                  <b-form-group label="Nomor Telepon" label-cols-md="4">
                    <b-form-input v-model="dataPegawai.nomor_telepon" />
                  </b-form-group>
                  <b-form-group label="Nomor Rekening" label-cols-md="4">
                    <b-form-input v-model="dataPegawai.nomor_rekening" />
                  </b-form-group>
                  <b-form-group label="Nomor Pokok Wajib Pajak" label-cols-md="4">
                    <b-form-input v-model="dataPegawai.npwp" />
                  </b-form-group>
                  <hr />
                  <b-form-group label="Tanggal Mulai Bekerja" label-cols-md="4">
                    <flat-pickr v-model="dataPegawai.tanggal_masuk" class="form-control" :config="date.config" />
                  </b-form-group>
                  <b-form-group label="Penempatan" label-cols-md="4">
                    <v-select
                      v-model="dataPegawai.cabang_id"
                      :value="dataPegawai.cabang_id"
                      :options="cabangOptions"
                      label="nama"
                      :reduce="cabang => cabang.id"
                      :clearable="false"
                      class="per-page-selector d-inline-block mr-1"
                    />
                  </b-form-group>
                  <b-form-group label="Divisi" label-cols-md="4">
                    <v-select
                      v-model="dataPegawai.divisi_id"
                      :value="dataPegawai.divisi_id"
                      :options="divisiOptions"
                      label="nama"
                      :reduce="divisi => divisi.id"
                      :clearable="false"
                      class="per-page-selector d-inline-block mr-1"
                    />
                  </b-form-group>
                  <b-form-group label="Jabatan" label-cols-md="4">
                    <v-select
                      v-model="dataPegawai.jabatan_id"
                      :value="dataPegawai.jabatan_id"
                      :options="jabatanOptions"
                      label="nama"
                      :reduce="jabatan => jabatan.id"
                      :clearable="false"
                      class="per-page-selector d-inline-block mr-1"
                    />
                  </b-form-group>
                  <b-col offset-md="4">
                    <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" type="submit" variant="primary" class="mr-1">
                      Submit
                    </b-button>
                    <b-button v-ripple.400="'rgba(186, 191, 199, 0.15)'" type="reset" variant="outline-secondary">
                      Reset
                    </b-button>
                  </b-col>
                </b-form>
              </div>
            </b-col>
          </b-card>
        </b-col>
      </b-row>
    </div>
  </section>
</template>

<script>
import store from '@/store'
import { ref } from '@vue/composition-api'

import { BButton, BRow, BCol, BForm, BFormInput, BFormGroup, BCard } from 'bootstrap-vue'
import Ripple from 'vue-ripple-directive'
import vSelect from 'vue-select'
import flatPickr from 'vue-flatpickr-component'

export default {
  components: {
    BButton,
    BForm,
    BFormInput,
    BFormGroup,
    vSelect,
    flatPickr,
    BRow,
    BCol,
    BCard,
  },
  directives: {
    Ripple,
  },
  data() {
    return {
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
