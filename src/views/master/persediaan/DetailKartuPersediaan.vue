<template>
  <section>
    <template>
      <b-row>
        <b-col cols="12" md="3" xl="3">
          <b-card>
            <b-form-group label="Kode Barang" label-for="kode-barang" label-cols-md="4">
              <b-form-input placeholder="Kode Barang" v-model="dataItem.kode_barang" type="text" readonly />
            </b-form-group>
            <b-form-group label="Nama Barang" label-for="nama-barang" label-cols-md="4">
              <b-form-input placeholder="Nama Barang" v-model="dataItem.nama" type="text" readonly />
            </b-form-group>
            <b-form-group label="Gudang" label-for="nama-barang" label-cols-md="4">
              <b-form-input placeholder="Gudang" type="text" v-model="dataItem.nama_gudang" readonly />
            </b-form-group>
            <b-form-group label="Saldo (Qty)" label-for="saldo-qty" label-cols-md="4">
              <b-form-input placeholder="Saldo (Qty)" type="text" v-model="dataItem.persediaan.saldo" readonly />
            </b-form-group>
            <b-form-group label="Saldo (Rp)" label-for="saldo-rp" label-cols-md="4">
              <b-form-input placeholder="Saldo (Rp)" type="text" v-model="saldoRupiah" readonly />
            </b-form-group>
            <hr />
            <!-- Button: Download -->
            <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="primary" class="mb-75" block>
              Download
            </b-button>
          </b-card>
        </b-col>
        <b-col cols="12" md="9" xl="9">
          <b-card>
            <kartu-persediaan :data-persediaan="dataPersediaan" :id="id" />
          </b-card>
        </b-col>
      </b-row>
    </template>
  </section>
</template>

<script>
import store from '@/store'
import router from '@/router'
import { BFormGroup, BFormInput, BButton, BRow, BCol, BCard } from 'bootstrap-vue'
import Ripple from 'vue-ripple-directive'
import KartuPersediaan from './component/KartuPersediaan.vue'

export default {
  components: {
    BFormGroup,
    BFormInput,
    BButton,
    BRow,
    BCol,
    BCard,
    KartuPersediaan,
  },
  directives: {
    Ripple,
  },
  data() {
    return {
      dataPersediaan: [],
      dataItem: {},
    }
  },
  computed: {
    dataBarang() {
      if (!this.data) return null
      return this.data
    },
    id() {
      return router.currentRoute.params.id
    },
    saldoRupiah() {
      if (this.dataItem.persediaan.saldo_rp === null) {
        return 'Rp. 0'
      }
      return this.formatRupiah(this.dataItem.persediaan.saldo_rp)
    },
  },
  created() {
    this.load()
  },
  methods: {
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
    load() {
      this.dataItem = router.currentRoute.params.item
      store.dispatch('app-persediaan/fetchKartuPersediaan', router.currentRoute.params).then(res => {
        store.commit('app-persediaan/SET_KARTU_PERSEDIAAN', res.data)
        this.dataPersediaan = store.getters['app-persediaan/getKartuPersediaan']
      })
    },
  },
}
</script>
