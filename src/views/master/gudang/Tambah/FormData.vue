<template>
  <b-card>
    <b-card-header class="pb-50">
      <h4>
        Detail Data
      </h4>
    </b-card-header>
    <b-card-body>
      <b-form @submit.prevent v-on:submit="create" autocomplete="off">
        <b-row>
          <b-col cols="12">
            <b-form-group label="Tipe Kontak" label-for="tipe" label-cols-md="4">
              <v-select v-model="form.tipe" placeholder="Jenis Kontak" :reduce="nama => nama.id" label="nama" :options="tipeKontak" />
            </b-form-group>
          </b-col>

          <b-col cols="12">
            <b-form-group label="Nama" label-for="nama_kontak" label-cols-md="4">
              <b-form-input v-model="form.nama" id="nama_kontak" placeholder="Nama Kontak" required />
            </b-form-group>
          </b-col>

          <b-col cols="12">
            <b-form-group label="Telepon" label-for="telepon" label-cols-md="4">
              <b-form-input v-model="form.telepon" id="telepon" placeholder="Telepon" required />
            </b-form-group>
          </b-col>

          <b-col cols="12">
            <b-form-group label="Identitas" label-for="identitas" label-cols-md="4">
              <b-form-input v-model="form.identitas" id="identitas" placeholder="Identitas ( No. KTP / No. SIM / Lainnya)" required />
            </b-form-group>
          </b-col>

          <b-col cols="12">
            <b-form-group label="Nomor Npwp" label-for="npwp" label-cols-md="4">
              <b-form-input v-model="form.npwp" id="npwp" placeholder="Nomor NPWP" type="email" />
            </b-form-group>
          </b-col>

          <b-col cols="12">
            <b-form-group label="Alamat Email" label-for="email" label-cols-md="4">
              <b-form-input v-model="form.email" id="email" placeholder="Alamat Email" />
            </b-form-group>
          </b-col>

          <b-col cols="12">
            <b-form-group label="Nama Perusahaan" label-for="nama_perusahaan" label-cols-md="4">
              <b-form-input v-model="form.nama_perusahaan" id="nama_perusahaan" placeholder="Nama Perusahaan" />
            </b-form-group>
          </b-col>

          <b-col cols="12">
            <b-form-group label="Alamat" label-for="alamat" label-cols-md="4" v-model="form.alamat">
              <b-form-textarea id="alamat" placeholder="Alamat" rows="3" />
            </b-form-group>
          </b-col>

          <b-col cols="12">
            <b-form-group label="Info Lainnya" label-for="info_lain" label-cols-md="4" v-model="form.info_lain">
              <b-form-textarea id="info_lain" placeholder="Info Lainnya" rows="3" />
            </b-form-group>
          </b-col>

          <!-- submit and reset -->
          <b-col offset-md="4">
            <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" type="submit" variant="primary" class="mr-1">
              Submit
            </b-button>

            <b-button v-ripple.400="'rgba(186, 191, 199, 0.15)'" type="reset" variant="outline-secondary">
              Reset
            </b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-card-body>
  </b-card>
</template>

<script>
import { BRow, BCol, BFormGroup, BFormInput, BForm, BButton, BCard, BCardHeader, BCardBody, BFormTextarea } from 'bootstrap-vue'
import Ripple from 'vue-ripple-directive'
import vSelect from 'vue-select'
import axios from 'axios'

export default {
  components: {
    vSelect,
    BCardHeader,
    BFormTextarea,
    BCard,
    BCardBody,
    BRow,
    BCol,
    BFormGroup,
    BFormInput,
    BForm,
    BButton,
  },
  directives: {
    Ripple,
  },
  data() {
    return {
      form: {
        nama: '',
        tipe: '',
        telepon: '',
        email: '',
        alamat: '',
        nama_perusahaan: '',
        info_lain: '',
        npwp: '',
        identitas: '',
      },
      selected: '',
      tipeKontak: [
        {
          nama: 'Pelanggan',
          id: 1,
        },
        {
          nama: 'Supplier',
          id: 2,
        },
      ],
      merekBarang: [],
      satuanBarang: [],
    }
  },
  mounted() {
    this.load()
  },
  methods: {
    success() {
      this.$swal({
        title: 'Success!',
        text: 'Data has been created!!',
        icon: 'success',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
      this.$router.push({
        name: 'master-barang',
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
    create() {
      axios.post('http://127.0.0.1:8000/api/barang/store', this.form).then(res => {
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
