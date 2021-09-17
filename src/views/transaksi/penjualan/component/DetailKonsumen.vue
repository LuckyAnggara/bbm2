<template>
  <section>
    <b-row>
      <b-col cols="6" class="mb-2">
        <b-form>
          <b-row>
            <b-col cols="12" class="mb-2">
              <h5 class="mb-0">
                Detail Konsumen
              </h5>
              <small class="text-muted">
                Masukan Detail Konsumen.
              </small>
            </b-col>
            <b-col md="12">
              <b-form-group label="Kode Pelanggan" label-for="nama-pelanggan-lama" class="mb-2">
                <v-select v-model="dataOrder.pelanggan" clear label="nama" placeholder="Nama Pelanggan" :options="option">
                  <template #list-header>
                    <li v-b-toggle.sidebar-add-kontak class="add-new-data-header d-flex align-items-center my-50">
                      <feather-icon icon="PlusIcon" size="16" />
                      <span class="align-middle ml-25">Tambah Pelanggan</span>
                    </li>
                  </template>
                </v-select>
              </b-form-group>
            </b-col>
          </b-row>
          <b-row>
            <b-col md="12">
              <b-form-group label="Nama Pelanggan*" label-for="nama-pelanggan" class="mb-2">
                <b-form-input
                  id="nama-pelanggan"
                  v-model="dataOrder.pelanggan.nama"
                  placeholder="Nama Pelanggan"
                  trim
                  :readonly="dataOrder.pelanggan.wic === 0 ? true : false"
                />
              </b-form-group>
            </b-col>
          </b-row>
          <b-row>
            <b-col md="12">
              <b-form-group label="Alamat Pelanggan*" label-for="alamat-pelanggan" class="mb-2">
                <b-form-textarea
                  id="alamat-pelanggan"
                  v-model="dataOrder.pelanggan.alamat"
                  placeholder="Alamat Pelanggan"
                  rows="4"
                  trim
                  :readonly="dataOrder.pelanggan.wic === 0 ? true : false"
                />
              </b-form-group>
            </b-col>
          </b-row>
          <b-row>
            <b-col md="6">
              <b-form-group label="Nomor Telepon" label-for="nomor-telepon" class="mb-2">
                <b-form-input
                  id="nomor-telepon"
                  v-model="dataOrder.pelanggan.telepon"
                  placeholder="Nomor Telepon (Optional)"
                  type="number"
                  trim
                  :readonly="dataOrder.pelanggan.wic === 0 ? true : false"
                />
              </b-form-group>
            </b-col>
          </b-row>
        </b-form>
      </b-col>
      <b-col cols="6" class="mb-2">
        <p>Status Konsumen adalah</p>
        <h2 class="text-danger">{{ dataOrder.pelanggan.wic === true ? 'WALK IN CUSTOMER' : 'PELANGGAN' }}</h2>
        <hr />
        <p>
          <u><strong>Note!</strong></u>
        </p>

        <p><strong class="text-warning">Walk In Customer</strong> tidak dapat diberikan fasilitas pembayaran <strong>Kredit</strong></p>
        <p><strong class="text-success">Pelanggan</strong> dapat diberikan fasilitas pembayaran <strong>Kredit</strong></p>
        <hr />
        <section v-if="dataOrder.pelanggan.akun_piutang_id === null">
          <p>
            <strong class="text-danger">{{ dataOrder.pelanggan.nama }}</strong> belum bisa diberikan Fasilitas <strong class="text-danger">Kredit</strong>,
            silahkan Atur <strong class="text-danger">Akun Piutang</strong> nya di Menu Kontak
          </p>
        </section>
      </b-col>
    </b-row>

    <sidebar-kontak @update-kontak="updateKontak" />
  </section>
</template>

<script>
import { BForm, BRow, BCol, BFormTextarea, BFormGroup, BFormInput, VBToggle } from 'bootstrap-vue'
import vSelect from 'vue-select'
import store from '@/store'
import SidebarKontak from './SidebarAddKontak.vue'
// import TreeDropdownVue from '@/views/extensions/tree/TreeDropdown.vue'

export default {
  components: {
    // BSV
    BForm,
    BRow,
    BCol,
    BFormTextarea,

    BFormGroup,
    BFormInput,

    // 3rd party
    vSelect,
    SidebarKontak,
  },
  directives: {
    'b-toggle': VBToggle,
  },
  props: {
    dataOrder: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      selectPelanggan: null,
      option: [],
    }
  },
  beforeMount() {
    this.loadDataPelanggan()
  },
  methods: {
    updateKontak(e) {
      this.selectPelanggan = this.option.find(item => item.id === parseInt(e.id, 10))
      this.dataOrder.pelanggan.id = e.id
      this.dataOrder.pelanggan.nama = e.nama
      this.dataOrder.pelanggan.alamat = e.alamat
      this.dataOrder.pelanggan.telepon = e.telepon
    },
    loadDataPelanggan() {
      const user = JSON.parse(localStorage.getItem('userData'))
      if (store.getters['app-kontak/getListPelanggan'].length === 0) {
        store.dispatch('app-kontak/fetchListKontak').then(res => {
          store.commit('app-kontak/SET_LIST_KONTAK', res.data)
          this.option = store.getters['app-kontak/getListPelanggan'].filter(x => x.cabang_id === user.cabang_id)
        })
      } else {
        this.option = store.getters['app-kontak/getListPelanggan'].filter(x => x.cabang_id === user.cabang_id)
      }
    },
    // choosePelanggan() {
    //   if (this.selectPelanggan.id !== null) {
    //     this.dataOrder.pelanggan.id = this.selectPelanggan.id
    //     this.dataOrder.pelanggan.nama = this.selectPelanggan.nama
    //     this.dataOrder.pelanggan.alamat = this.selectPelanggan.alamat
    //     this.dataOrder.pelanggan.telepon = this.selectPelanggan.telepon
    //     this.dataOrder.pelanggan.wic = false
    //   } else {
    //     this.dataOrder.pelanggan.id = ''
    //     this.dataOrder.pelanggan.nama = ''
    //     this.dataOrder.pelanggan.alamat = ''
    //     this.dataOrder.pelanggan.telepon = ''
    //     this.dataOrder.pelanggan.wic = true
    //   }
    // },
  },
}
</script>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
.add-new-data-header {
  padding: $options-padding-y $options-padding-x;
  color: $success;

  &:hover {
    background-color: rgba($success, 0.12);
  }
}
</style>
