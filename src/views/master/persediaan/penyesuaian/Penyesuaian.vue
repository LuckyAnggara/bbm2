<template>
  <section>
    <b-row>
      <b-col lg="6" cols="6">
        <b-card>
          <h5>Form Penyesuaian Persediaan</h5>
          <hr />
          <b-form-group label="Gudang" label-for="ke" label-cols-md="4">
            <v-select v-model="form.gudang" :options="listGudang" label="nama" :clearable="true" />
          </b-form-group>

          <b-form-group label="Tipe Penyesuaian" label-for="tipe" label-cols-md="4">
            <v-select :clearable="false" v-model="form.tipe" placeholder="Tipe Penyesuaian" label="title" :options="tipePenyesuaian" />
          </b-form-group>

          <b-form-group label="Kategori" label-for="tipe" label-cols-md="4">
            <v-select v-model="form.kategori" placeholder="Kategori" label="title" :clearable="false" :options="kategori" />
          </b-form-group>

          <b-form-group label="Akun" label-for="akun" label-cols-md="4">
            <b-form-input placeholder="Akun" v-model="form.kategori.data.text" type="text" readonly />
          </b-form-group>

          <b-form-group label="Tanggal Transaksi" label-for="tanggalTransaksi" label-cols-md="4">
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
        <b-card title="Daftar Dokumen Penyesuaian">
          <daftar-penyesuaian @searchdata="searchQuery" :data-penyesuaian="dataPenyesuaian" />
        </b-card>
      </b-col>
    </b-row>
  </section>
</template>

<script>
import router from '@/router'
// import store from '@/store'
import { ref } from '@vue/composition-api'

import { BCard, BFormInput, BButton, BFormGroup, BRow, BCol, BFormTextarea, BFormDatepicker } from 'bootstrap-vue'
import vSelect from 'vue-select'
import Ripple from 'vue-ripple-directive'
import DaftarPenyesuaian from '../component/DaftarPenyesuaian.vue'

export default {
  components: {
    DaftarPenyesuaian,
    BFormDatepicker,
    BFormTextarea,
    BButton,
    vSelect,
    BFormInput,
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
        this.dataPenyesuaian = this.dataTemp
      } else {
        this.dataPenyesuaian = this.dataTemp.filter(
          item => item.nomor_opname.toLowerCase().indexOf(query.toLowerCase()) > -1 || item.catatan.toLowerCase().indexOf(query.toLowerCase()) > -1,
        )
      }
    },
    submit() {
      const x = this.form
      if (x.gudang === '' || x.gudang === null || x.tanggalTransaksi === '' || x.tanggalTransaksi === null || x.catatan === '' || x.catatan === null) {
        this.$swal({
          title: 'Error!',
          text: 'Form belum di isi lengkap',
          icon: 'error',
          customClass: {
            confirmButton: 'btn btn-primary',
          },
          buttonsStyling: false,
        })
      } else {
        // eslint-disable-next-line
        if (this.form.tipe.value === 0) {
          router.push({ name: 'master-persediaan-penyesuaian-perhitungan-stock', params: this.form })
        } else {
          router.push({ name: 'master-persediaan-penyesuaian-masuk-keluar', params: this.form })
        }
      }
    },
    // eslint-enable-next-line
    loadGudang() {
      const user = JSON.parse(localStorage.getItem('userData'))
      const cabang = user.cabang_id
      this.$store
        .dispatch('app-persediaan/fetchListGudang', {
          cabang,
        })
        .then(res => {
          this.$store.commit('app-persediaan/SET_LIST_GUDANG', res.data)
          this.listGudang = this.$store.getters['app-persediaan/getListGudang']
        })
    },
    loadDataPenyesuaian() {
      const user = JSON.parse(localStorage.getItem('userData'))
      this.$store
        .dispatch('app-persediaan/fetcListDataPenyesuaian', {
          cabang: user.cabang_id,
        })
        .then(res => {
          this.$store.commit('app-persediaan/SET_LIST_DATA_PENYESUAIAN', res.data)
          this.dataPenyesuaian = res.data
          this.dataTemp = res.data
        })
    },
  },
  mounted() {
    this.loadGudang()
    this.loadDataPenyesuaian()
  },
  setup() {
    const dataPenyesuaian = ref([])
    const dataTemp = ref([])
    const listGudang = ref([])
    const form = ref({
      tipe: {
        title: 'Perhitungan Stok',
        value: 0,
      },
      gudang: {},
      catatan: '',
      kategori: {
        title: 'Umum',
        value: 0,
        data: {
          id: 6,
          text: '1.1.5 - PERSEDIAAN DAGANG',
        },
      },
      tanggalTransaksi: '',
    })

    const kategori = [
      {
        title: 'Umum',
        value: 0,
        data: {
          id: 6,
          text: '1.1.5 - PERSEDIAAN DAGANG',
        },
      },
      {
        title: 'Barang Rusak',
        value: 1,
        data: {
          id: 6,
          text: '1.1.5 - PERSEDIAAN DAGANG',
        },
      },
      {
        title: 'Produksi',
        value: 2,
        data: {
          id: 6,
          text: '1.1.5 - PERSEDIAAN DAGANG',
        },
      },
      {
        title: 'Kuantitas Awal',
        value: 3,
        data: {
          id: 6,
          text: '1.1.5 - PERSEDIAAN DAGANG',
        },
      },
    ]
    const tipePenyesuaian = [
      {
        title: 'Perhitungan Stok',
        value: 0,
      },
      {
        title: 'Stok Masuk / Keluar',
        value: 1,
      },
    ]
    return {
      listGudang,
      dataTemp,
      dataPenyesuaian,
      form,
      kategori,
      tipePenyesuaian,
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
@import '@core/scss/vue/libs/vue-flatpicker.scss';
</style>
