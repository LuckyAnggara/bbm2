<template>
  <b-row>
    <b-col sm="12" lg="4" xl="4" md="4">
      <b-card>
        <b-form @submit="onSubmit" @reset="onReset">
          <b-form-group label="Tanggal P.O">
            <b-form-datepicker v-model="form.tanggal" locale="id" />
          </b-form-group>
          <b-form-group label="Ke Cabang" label-for="jumlah">
            <v-select placeholder="Pilih Tujuan" v-model="form.cabang_tujuan" label="nama" :options="listCabang" :clearable="false" />
          </b-form-group>
          <b-form-group label="Catatan" label-for="catatan">
            <b-form-textarea id="catatan" v-model="form.catatan" placeholder="Catatan" type="text" />
          </b-form-group>

          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" type="submit" variant="primary" class="mr-1">
            Submit
          </b-button>
          <b-button v-ripple.400="'rgba(186, 191, 199, 0.15)'" type="reset" variant="outline-secondary">
            Reset
          </b-button>
        </b-form>
      </b-card>
    </b-col>
    <b-col sm="12" lg="8" xl="8" md="8">
      <keranjang :data-order="form" />
    </b-col>
  </b-row>
</template>

<script>
import store from '@/store'
import { ref } from '@vue/composition-api'
import Ripple from 'vue-ripple-directive'
import { BRow, BCol, BForm, BCard, BFormGroup, BFormTextarea, BFormDatepicker, BButton } from 'bootstrap-vue'
import vSelect from 'vue-select'

import Keranjang from './component/Keranjang.vue'

export default {
  components: {
    BRow,
    BCol,
    BCard,
    BFormGroup,
    BFormTextarea,
    BFormDatepicker,
    BForm,
    vSelect,
    Keranjang,
    BButton,
  },
  directives: {
    Ripple,
  },
  created() {
    this.loadCabang()
  },
  methods: {
    error(text) {
      this.$swal({
        title: 'Error!',
        text,
        icon: 'error',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
    },
    success() {
      this.$swal({
        title: 'Success!',
        text: 'P.O berhasil dikirim. Silahkan konfirmasi ke Cabang tujuan',
        icon: 'success',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
    },
    onSubmit(event) {
      event.preventDefault()
      if (this.form.tanggal === null || this.form.tanggal === '') {
        this.error('Cek kembali Form Isian dan Keranjang Pesanan, mohon lengkapi!')
        return
      }
      if (this.form.catatan === null || this.form.catatan === '') {
        this.error('Cek kembali Form Isian dan Keranjang Pesanan, mohon lengkapi!')
        return
      }
      if (this.form.cabang_tujuan === null || this.form.cabang_tujuan === '') {
        this.error('Cek kembali Form Isian dan Keranjang Pesanan, mohon lengkapi!')
        return
      }
      if (this.form.orders.length < 1) {
        this.error('Cek kembali Form Isian dan Keranjang Pesanan, mohon lengkapi!')
        return
      }
      this.store()
    },
    onReset(event) {
      event.preventDefault()
      this.form.cabang_tujuan = null
      this.form.catatan = null
      this.form.tanggal = new Date()
      this.form.orders = []
    },
    loadCabang() {
      store.dispatch('app-pegawai/fetchListCabang').then(res => {
        this.listCabang = res.data.filter(x => x.id !== this.dataUser.cabang_id)
      })
    },
    store() {
      const loader = this.$loading.show({
        // Optional parameters
        container: this.$refs.formContainer,
      })
      store
        .dispatch('app-po/storePO', this.form)
        .then(res => {
          loader.hide()
          if (res.status === 200) {
            this.success()
            this.$router.push({
              name: 'transaksi-po-detail',
              params: { id: res.data.id, data: res.data },
            })
          } else {
            this.error(res.message)
          }
        })
        .catch(error => {
          this.error(error)
        })
    },
  },
  setup() {
    const form = ref({
      cabang_tujuan: null,
      catatan: null,
      tanggal: new Date(),
      orders: [],
      user: JSON.parse(localStorage.getItem('userData')),
    })
    const listCabang = ref([])
    const dataUser = JSON.parse(localStorage.getItem('userData'))

    return {
      form,
      listCabang,
      dataUser,
    }
  },
}
</script>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
</style>
