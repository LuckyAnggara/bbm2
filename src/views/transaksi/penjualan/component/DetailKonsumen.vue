<template>
  <section>
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
        <b-col md="6">
          <b-form-group label="Kode Pelanggan" label-for="nama-pelanggan-lama" class="mb-2">
            <v-select
              v-model="selectPelanggan"
              label="nama"
              placeholder="Nama Pelanggan"
              :reduce="kontak => kontak.id"
              :options="option"
              @input="choosePelanggan"
            >
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
        <b-col md="6">
          <b-form-group label="Nama Pelanggan*" label-for="nama-pelanggan" class="mb-2">
            <b-form-input id="nama-pelanggan" v-model="dataOrder.pelanggan.nama" placeholder="Nama Pelanggan" trim />
          </b-form-group>
        </b-col>
      </b-row>
      <b-row>
        <b-col md="6">
          <b-form-group label="Alamat Pelanggan*" label-for="alamat-pelanggan" class="mb-2">
            <b-form-textarea id="alamat-pelanggan" v-model="dataOrder.pelanggan.alamat" placeholder="Alamat Pelanggan" rows="4" trim />
          </b-form-group>
        </b-col>
      </b-row>
      <b-row>
        <b-col md="6">
          <b-form-group label="Nomor Telepon" label-for="nomor-telepon" class="mb-2">
            <b-form-input id="nomor-telepon" v-model="dataOrder.pelanggan.nomorTelepon" placeholder="Nomor Telepon (Optional)" type="number" trim />
          </b-form-group>
        </b-col>
      </b-row>
    </b-form>
    <sidebar-kontak @update-kontak="updateKontak" />
  </section>
</template>

<script>
import { BForm, BRow, BCol, BFormTextarea, BFormGroup, BFormInput, VBToggle } from 'bootstrap-vue'
import vSelect from 'vue-select'
import store from '@/store'
import SidebarKontak from './SidebarAddKontak.vue'

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
      selectPelanggan: '',
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
      this.dataOrder.pelanggan.nomorTelepon = e.telepon
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
    choosePelanggan(id) {
      if (id !== null) {
        const pelanggan = this.option.find(d => d.id === id)
        this.dataOrder.pelanggan.id = pelanggan.id
        this.dataOrder.pelanggan.nama = pelanggan.nama
        this.dataOrder.pelanggan.alamat = pelanggan.alamat
        this.dataOrder.pelanggan.nomorTelepon = pelanggan.telepon
      } else {
        this.dataOrder.pelanggan.id = ''
        this.dataOrder.pelanggan.nama = ''
        this.dataOrder.pelanggan.alamat = ''
        this.dataOrder.pelanggan.nomorTelepon = ''
      }
    },
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
