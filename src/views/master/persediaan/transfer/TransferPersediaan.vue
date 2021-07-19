<template>
  <section>
    <b-row>
      <b-col lg="6" cols="6">
        <b-card>
          <h5>Form Transfer Persediaan</h5>
          <hr />
          <b-form-group label="Dari Gudang" label-for="dari" label-cols-md="4">
            <v-select
              v-model="form.dataGudang.dari"
              :options="listGudang"
              label="nama"
              :clearable="true"
              :selectable="option => option.id !== form.dataGudang.ke.id"
            />
          </b-form-group>
          <b-form-group label="Ke Gudang" label-for="ke" label-cols-md="4">
            <v-select
              v-model="form.dataGudang.ke"
              :options="listGudang"
              label="nama"
              :clearable="true"
              :selectable="option => option.id !== form.dataGudang.dari.id"
            />
          </b-form-group>

          <b-form-group label="Tanggal Transfer" label-for="tanggalTransfer" label-cols-md="4">
            <b-form-datepicker id="tanggalTransfer" v-model="form.tanggalTransaksi" />
          </b-form-group>

          <b-form-group label="Catatan" label-for="catatan" label-cols-md="4">
            <b-form-textarea placeholder="Catatan" v-model="form.catatan" type="text" />
          </b-form-group>

          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" type="button" @click="submit" variant="primary" class="mr-1">
            Next
          </b-button>
        </b-card>
      </b-col>

      <b-col lg="12" cols="6">
        <b-card title="Daftar Dokumen Transfer Persediaan">
          <daftar-transfer-persediaan @searchdata="searchQuery" :dataTransfer="dataTransfer" />
        </b-card>
      </b-col>
    </b-row>
  </section>
</template>

<script>
import router from '@/router'
import store from '@/store'
import { ref } from '@vue/composition-api'

import {
  BCard,
  BFormDatepicker,
  // BFormInput,
  BButton,
  BFormGroup,
  BRow,
  BCol,
  BFormTextarea,
} from 'bootstrap-vue'
import vSelect from 'vue-select'
import Ripple from 'vue-ripple-directive'
import DaftarTransferPersediaan from '../component/DaftarTransferPersediaan.vue'

export default {
  components: {
    DaftarTransferPersediaan,
    BFormTextarea,
    BFormDatepicker,
    BButton,
    vSelect,
    // BFormInput,
    BCard,
    BRow,
    BCol,
    BFormGroup,
  },
  directives: {
    Ripple,
  },
  methods: {
    searchQuery(query) {
      if (query === '') {
        this.dataTransfer = this.dataTemp
      } else {
        this.dataTransfer = this.dataTemp.filter(
          item => item.nomor_transfer.toLowerCase().indexOf(query.toLowerCase()) > -1 || item.catatan.toLowerCase().indexOf(query.toLowerCase()) > -1,
        )
      }
    },
    errorProses(x) {
      let t
      if (x === 'a') {
        t = 'Gudang asal belum di pilih'
      } else if (x === 'b') {
        t = 'Gudang tujuan belum di pilih'
      } else if (x === 'c') {
        t = 'Form belum di isi lengkap'
      }

      this.$swal({
        title: 'Error!',
        text: t,
        icon: 'error',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
    },
    submit() {
      if (this.form.dataGudang.dari === null || this.form.dataGudang.dari === '') {
        this.errorProses('a')
      } else if (this.form.dataGudang.ke === null || this.form.dataGudang.ke === '') {
        this.errorProses('b')
      } else if (this.form.tanggalTransaksi === null || this.form.tanggalTransaksi === '' || this.form.catatan === null || this.form.catatan === '') {
        this.errorProses('c')
      } else {
        router.push({ name: 'master-persediaan-transfer-lanjut', params: this.form })
      }
    },
    loadGudang() {
      const user = JSON.parse(localStorage.getItem('userData'))
      const cabang = user.cabang_id
      store
        .dispatch('app-persediaan/fetchListGudang', {
          cabang,
        })
        .then(res => {
          store.commit('app-persediaan/SET_LIST_GUDANG', res.data)
          this.listGudang = store.getters['app-persediaan/getListGudang']
        })
    },
    loadDaftarTransfer() {
      const user = JSON.parse(localStorage.getItem('userData'))
      const cabang = user.cabang_id

      store
        .dispatch('app-persediaan/fetcListDataTransfer', {
          cabang,
        })
        .then(res => {
          this.$store.commit('app-persediaan/SET_LIST_DATA_TRANSFER', res.data)
          this.dataTransfer = res.data
          this.dataTemp = res.data
        })
    },
  },
  mounted() {
    this.loadGudang()
    this.loadDaftarTransfer()
  },
  setup() {
    const dataTransfer = ref([])
    const dataTemp = ref([])
    const listGudang = ref([])
    const form = ref({
      dataGudang: {
        dari: {
          id: '',
          nama: '',
        },
        ke: {
          id: '',
          nama: '',
        },
      },
      catatan: '',
      tanggalTransaksi: '',
    })
    return {
      dataTransfer,
      dataTemp,
      listGudang,
      form,
    }
  },
}
</script>

<style lang="scss" scoped>
.per-page-selector {
  width: 90px;
}
</style>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
</style>
