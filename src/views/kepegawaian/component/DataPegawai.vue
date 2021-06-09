<template>
  <section>
    <div ref="container">
      <template>
        <b-row>
          <b-col lg="9" cols="12">
            <div class="mt-2">
              <table class="mt-xl-0 w-100">
                <tr>
                  <th class="pb-50">
                    <span class="font-weight-bold">Nomor KTP</span>
                  </th>
                  <td class="pb-50">
                    <b-form-input v-model="dataDiri.ktp" :readonly="edit" />
                  </td>
                </tr>
                <tr>
                  <th class="pb-50">
                    <span class="font-weight-bold">Nama Lengkap</span>
                  </th>
                  <td class="pb-50">
                    <b-form-input v-model="dataDiri.nama" :readonly="edit" />
                  </td>
                </tr>
                <tr>
                  <th class="pb-50">
                    <span class="font-weight-bold">Jenis Kelamin</span>
                  </th>
                  <td class="pb-50" v-show="edit">
                    <b-form-input v-model="dataDiri.jenis_kelamin" :readonly="edit" />
                  </td>
                  <td class="pb-50" v-show="!edit">
                    <v-select
                      v-model="dataDiri.jenis_kelamin"
                      :value="dataDiri.jenis_kelamin"
                      :options="jenisKelaminOptions"
                      :clearable="false"
                      :readonly="edit"
                      class="per-page-selector d-inline-block mr-1"
                    />
                  </td>
                </tr>
                <tr>
                  <th class="pb-50">
                    <span class="font-weight-bold">Tanggal Lahir</span>
                  </th>
                  <td class="pb-50" v-show="edit">
                    <b-form-input v-model="dataDiri.tanggal_lahir" :readonly="edit" />
                  </td>
                  <td class="pb-50" v-show="!edit">
                    <flat-pickr v-model="dataDiri.tanggal_lahir" class="form-control" :config="date.config" :readonly="edit" />
                  </td>
                </tr>
                <tr>
                  <th class="pb-50">
                    <span class="font-weight-bold">Pendidikan Terakhir</span>
                  </th>
                  <td class="pb-50" v-show="edit">
                    <b-form-input v-model="dataDiri.pendidikan_terakhir" :readonly="edit" />
                  </td>
                  <td class="pb-50" v-show="!edit">
                    <v-select
                      v-model="dataDiri.pendidikan_terakhir"
                      :value="dataDiri.pendidikan_terakhir"
                      :options="pendidikanOptions"
                      :clearable="false"
                      :readonly="edit"
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
                    <b-form-input v-model="dataDiri.alamat" :readonly="edit" />
                  </td>
                </tr>
                <tr>
                  <th class="pb-50">
                    <span class="font-weight-bold">Kecamatan</span>
                  </th>
                  <td class="pb-50">
                    <b-form-input v-model="dataDiri.kecamatan" :readonly="edit" />
                  </td>
                </tr>
                <tr>
                  <th class="pb-50">
                    <span class="font-weight-bold">Kelurahan</span>
                  </th>
                  <td class="pb-50">
                    <b-form-input v-model="dataDiri.kelurahan" :readonly="edit" />
                  </td>
                </tr>
                <tr>
                  <th class="pb-50">
                    <span class="font-weight-bold">Kota</span>
                  </th>
                  <td class="pb-50">
                    <b-form-input v-model="dataDiri.kota" :readonly="edit" />
                  </td>
                </tr>
                <hr />
                <tr>
                  <th class="pb-50">
                    <span class="font-weight-bold">Nomor Telepon</span>
                  </th>
                  <td class="pb-50">
                    <b-form-input v-model="dataDiri.nomor_telepon" :readonly="edit" />
                  </td>
                </tr>
                <tr>
                  <th class="pb-50">
                    <span class="font-weight-bold">Nomor Rekening</span>
                  </th>
                  <td class="pb-50">
                    <b-form-input v-model="dataDiri.nomor_rekening" :readonly="edit" />
                  </td>
                </tr>
                <tr>
                  <th class="pb-50">
                    <span class="font-weight-bold">Nomor Pokok Wajib Pajak</span>
                  </th>
                  <td class="pb-50">
                    <b-form-input v-model="dataDiri.npwp" :readonly="edit" />
                  </td>
                </tr>
                <hr />
                <tr>
                  <th>
                    <!-- <feather-icon icon="PhoneIcon" class="mr-75" /> -->
                    <span class="font-weight-bold">Tanggal Mulai Bekerja</span>
                  </th>
                  <td class="pb-50" v-show="edit">
                    <b-form-input v-model="dataDiri.tanggal_masuk" :readonly="edit" />
                  </td>
                  <td class="pb-50" v-show="!edit">
                    <flat-pickr v-model="dataDiri.tanggal_masuk" class="form-control" :config="date.config" :readonly="edit" />
                  </td>
                </tr>
                <tr>
                  <th>
                    <!-- <feather-icon icon="PhoneIcon" class="mr-75" /> -->
                    <span class="font-weight-bold">Penempatan</span>
                  </th>
                  <td class="pb-50" v-show="edit">
                    <b-form-input v-model="dataDiri.cabang" :readonly="edit" />
                  </td>
                  <td class="pb-50" v-show="!edit">
                    <v-select
                      v-model="dataDiri.cabang_id"
                      :value="dataDiri.cabang_id"
                      :options="cabangOptions"
                      label="nama"
                      :reduce="cabang => cabang.id"
                      :clearable="false"
                      :readonly="edit"
                      class="per-page-selector d-inline-block mr-1"
                    />
                  </td>
                </tr>

                <tr>
                  <th>
                    <!-- <feather-icon icon="PhoneIcon" class="mr-75" /> -->
                    <span class="font-weight-bold">Divisi</span>
                  </th>
                  <td class="pb-50" v-show="edit">
                    <b-form-input v-model="dataDiri.divisi" :readonly="edit" />
                  </td>
                  <td class="pb-50" v-show="!edit">
                    <v-select
                      v-model="dataDiri.divisi_id"
                      :value="dataDiri.divisi_id"
                      :options="divisiOptions"
                      label="nama"
                      :reduce="divisi => divisi.id"
                      :clearable="false"
                      :readonly="edit"
                      class="per-page-selector d-inline-block mr-1"
                    />
                  </td>
                </tr>
                <tr>
                  <th>
                    <!-- <feather-icon icon="PhoneIcon" class="mr-75" /> -->
                    <span class="font-weight-bold">Jabatan</span>
                  </th>
                  <td class="pb-50" v-show="edit">
                    <b-form-input v-model="dataDiri.jabatan" :readonly="edit" />
                  </td>
                  <td class="pb-50" v-show="!edit">
                    <v-select
                      v-model="dataDiri.jabatan_id"
                      :value="dataDiri.jabatan_id"
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
        </b-row>
      </template>
    </div>
  </section>
</template>

<script>
import store from '@/store'
import { ref } from '@vue/composition-api'
import { BRow, BCol, BFormInput } from 'bootstrap-vue'
import vSelect from 'vue-select'
import flatPickr from 'vue-flatpickr-component'

export default {
  components: {
    BRow,
    BCol,
    BFormInput,
    vSelect,
    flatPickr,
  },

  data() {
    return {
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
  props: {
    dataDiri: {
      type: Object,
      required: true,
    },
    edit: {
      type: Boolean,
      required: true,
    },
  },
  methods: {
    convertInt(x) {
      return parseInt(x, 10)
    },
    loadDataSelect() {
      this.jabatanOptions = store.getters['app-pegawai/getListJabatan']
      this.divisiOptions = store.getters['app-pegawai/getListDivisi']
      this.cabangOptions = store.getters['app-pegawai/getListCabang']
    },
    loadInfoJabatanDivisiCabang() {
      store.dispatch('app-pegawai/fetchListJabatanDivisiCabang').then(res => {
        if (res.status === 200) {
          store.commit('app-pegawai/SET_LIST_JABATAN_DIVISI_CABANG', res.data)
          this.loadDataSelect()
        }
      })
    },
  },
  mounted() {
    this.loadInfoJabatanDivisiCabang()
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
