<template>
  <b-sidebar id="sidebar-add-kontak" sidebar-class="sidebar-lg" bg-variant="white" shadow backdrop no-header right>
    <template #default="{ hide }">
      <!-- Header -->
      <div class="d-flex justify-content-between align-items-center content-sidebar-header px-2 py-1">
        <h5 class="mb-0">
          Tambah Kontak
        </h5>

        <feather-icon class="ml-1 cursor-pointer" icon="XIcon" size="16" @click="hide" />
      </div>

      <!-- Body -->
      <b-form class="p-2" @submit.prevent>
        <!-- Customer Name -->
        <b-form-group label="Nama Kontak" label-for="nama-kontak">
          <b-form-input id="nama-kontak" v-model="nama" trim placeholder="Nama Kontak" />
        </b-form-group>

        <b-form-group label="Alamat" label-for="alamat-kontak">
          <b-form-textarea id="alamat-kontak" v-model="alamat" trim placeholder="Alamat" />
        </b-form-group>

        <b-form-group label="Nomor Telepon" label-for="telepon">
          <b-form-input id="telepon" v-model="nomorTelepon" trim placeholder="Nomor Telepon" />
        </b-form-group>
        <p>Silahkan lengkapi data Pelanggan setelah Transaksi</p>

        <!-- Form Actions -->
        <div class="d-flex mt-2">
          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="primary" class="mr-2" type="submit" @click="create">
            Add
          </b-button>
          <b-button v-ripple.400="'rgba(186, 191, 199, 0.15)'" variant="outline-secondary" @click="hide">
            Cancel
          </b-button>
        </div>
      </b-form>
    </template>
  </b-sidebar>
</template>

<script>
import { BSidebar, BForm, BFormGroup, BFormTextarea, BFormInput, BButton } from 'bootstrap-vue'
import Ripple from 'vue-ripple-directive'
import store from '@/store'

export default {
  components: {
    BSidebar,
    BFormTextarea,
    BForm,
    BFormGroup,
    BFormInput,
    BButton,
  },
  directives: {
    Ripple,
  },
  data() {
    return {
      nama: '',
      alamat: '',
      nomorTelepon: '',
      userData: JSON.parse(localStorage.getItem('userData')),
    }
  },
  methods: {
    error() {
      this.$swal({
        title: 'Error!',
        text: "Oopss there' a problem!",
        icon: 'error',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
    },
    suksesToast(nama) {
      this.$bvToast.toast(`Kontak ${nama} ditambahkan`, {
        title: 'Sukses',
        variant: 'success',
        toaster: 'b-toaster-bottom-center',
      })
    },
    create() {
      if (this.nama !== '') {
        store
          .dispatch('app-kontak/addKontak', {
            tipe: 'PELANGGAN',
            nama: this.nama,
            alamat: this.alamat,
            telepon: this.nomorTelepon,
            user: this.userData,
          })
          .then(res => {
            if (res.status === 200) {
              store.commit('app-kontak/UPDATE_LIST_KONTAK', res.data)
              this.$root.$emit('bv::toggle::collapse', 'sidebar-add-kontak')
              this.$emit('update-kontak', res.data)
              this.suksesToast(res.data.nama)
              this.nama = ''
              this.alamat = ''
              this.nomorTelepon = ''
            } else {
              this.error()
            }
          })
      }
    },
  },
}
</script>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
</style>
