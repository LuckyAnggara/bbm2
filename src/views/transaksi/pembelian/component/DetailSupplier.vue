<template>
  <section>
    <b-form>
      <b-row>
        <b-col cols="12" class="mb-2">
          <h5 class="mb-0">
            Detail Supplier
          </h5>
          <small class="text-muted">
            Masukan Detail Supplier.
          </small>
        </b-col>
        <b-col md="6">
          <b-form-group label="Kode Supplier" label-for="nama-supplier-lama" class="mb-2">
            <v-select v-model="selectSupplier" label="nama" placeholder="Nama Supplier" :reduce="kontak => kontak.id" :options="option" @input="chooseSupplier">
              <template #list-header>
                <li v-b-toggle.sidebar-add-kontak class="add-new-data-header d-flex align-items-center my-50">
                  <feather-icon icon="PlusIcon" size="16" />
                  <span class="align-middle ml-25">Tambah Supplier</span>
                </li>
              </template>
            </v-select>
          </b-form-group>
        </b-col>
      </b-row>
      <b-row>
        <b-col md="6">
          <b-form-group label="Nama Supplier*" label-for="nama-supplier" class="mb-2">
            <b-form-input id="nama-supplier" v-model="dataOrder.supplier.nama" placeholder="Nama Supplier" trim readonly />
          </b-form-group>
          <b-form-group label="Alamat Supplier*" label-for="alamat-supplier" class="mb-2">
            <b-form-textarea id="alamat-supplier" v-model="dataOrder.supplier.alamat" placeholder="Alamat Supplier" rows="4" trim readonly />
          </b-form-group>
          <b-form-group label="Nomor Telepon" label-for="nomor-telepon" class="mb-2">
            <b-form-input id="nomor-telepon" v-model="dataOrder.supplier.nomorTelepon" placeholder="Nomor Telepon (Optional)" type="number" trim readonly />
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
      selectSupplier: '',
      option: [],
    }
  },
  beforeMount() {
    this.loadDataSupplier()
  },
  methods: {
    updateKontak(e) {
      this.selectSupplier = this.option.find(item => item.id === parseInt(e.id, 10))
      this.dataOrder.supplier.id = e.id
      this.dataOrder.supplier.nama = e.nama
      this.dataOrder.supplier.alamat = e.alamat
      this.dataOrder.supplier.nomorTelepon = e.telepon
    },
    loadDataSupplier() {
      const user = JSON.parse(localStorage.getItem('userData'))
      if (store.getters['app-kontak/getListSupplier'].length === 0) {
        store.dispatch('app-kontak/fetchListKontak').then(res => {
          store.commit('app-kontak/SET_LIST_KONTAK', res.data)
          this.option = store.getters['app-kontak/getListSupplier'].filter(x => x.cabang_id === user.cabang_id || x.cabang_id === 0)
        })
      } else {
        this.option = store.getters['app-kontak/getListSupplier'].filter(x => x.cabang_id === user.cabang_id || x.cabang_id === 0)
      }
    },
    chooseSupplier(id) {
      if (id !== null) {
        const supplier = this.option.find(d => d.id === id)
        this.dataOrder.supplier.id = supplier.id
        this.dataOrder.supplier.nama = supplier.nama
        this.dataOrder.supplier.alamat = supplier.alamat
        this.dataOrder.supplier.nomorTelepon = supplier.telepon
        this.dataOrder.supplier.akun_utang_id = supplier.akun_utang_id
      } else {
        this.dataOrder.supplier.id = ''
        this.dataOrder.supplier.nama = ''
        this.dataOrder.supplier.alamat = ''
        this.dataOrder.supplier.nomorTelepon = ''
        this.dataOrder.supplier.akun_utang_id = ''
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
