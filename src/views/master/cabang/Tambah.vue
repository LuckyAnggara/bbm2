<template>
  <!-- <b-row class="match-height"> -->
  <b-form autocomplete="off" @submit.prevent @submit="store">
    <b-row>
      <b-col lg="9">
        <b-card title="Data Cabang">
          <b-row>
            <b-col cols="12">
              <b-form-group label="Nama Cabang" label-for="nama_barang" label-cols-md="4">
                <b-form-input id="nama_cabang" v-model="form.nama" placeholder="Nama Barang" required />
              </b-form-group>
            </b-col>

            <b-col cols="12">
              <b-form-group label="Alamat" label-cols-md="4">
                <b-form-textarea v-model="form.alamat" placeholder="Alamat Cabang" rows="3" />
              </b-form-group>
            </b-col>

            <b-col cols="12">
              <b-form-group label="Nomor Telepon" label-cols-md="4">
                <b-form-input v-model="form.nomor_telepon" placeholder="Nomor Telepon Cabang" type="text" />
              </b-form-group>
            </b-col>

            <b-col cols="12">
              <b-form-group label="Nomor Akun Kas" label-cols-md="4">
                <b-form-input placeholder="Nomor Akun Kas akan terbuat Otomatis" type="text" readonly />
              </b-form-group>
            </b-col>
          </b-row>
        </b-card>
      </b-col>
      <!-- Right Col: Card -->
      <b-col cols="12" md="4" xl="3" class="invoice-actions mt-md-0 mt-2">
        <!-- Action Buttons -->
        <b-card>
          <!-- Button: Send Invoice -->
          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="primary" class="mb-75" block type="submit">
            Submit
          </b-button>

          <b-button v-ripple.400="'rgba(113, 102, 240, 0.15)'" variant="outline-primary" class="mb-75" type="reset" block>
            Reset
          </b-button>
        </b-card>
      </b-col>
    </b-row>
  </b-form>
</template>

<script>
import { BForm, BCard, BRow, BCol, BButton, BFormGroup, BFormInput, BFormTextarea } from 'bootstrap-vue'
// import { ref } from '@vue/composition-api'
import Ripple from 'vue-ripple-directive'
import store from '@/store'

export default {
  components: {
    BCard,
    BForm,
    BRow,
    BCol,
    BFormGroup,
    BFormInput,
    BFormTextarea,
    BButton,
  },
  directives: {
    Ripple,
  },
  data() {
    return {
      form: {
        nama: null,
        alamat: null,
        nomor_teleon: null,
      },
    }
  },
  methods: {
    success() {
      this.$swal({
        title: 'Success!',
        text: 'Data berhasil dibuat!!',
        icon: 'success',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
      this.$router.push({
        name: 'master-cabang-daftar',
      })
    },
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
    store() {
      store.dispatch('app-cabang/tambahCabang', this.form).then(res => {
        if (res.status === 200) {
          this.success()
        } else {
          this.error()
        }
      })
    },
  },
}
</script>
