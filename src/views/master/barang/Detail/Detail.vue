<template>
  <section>
    <div ref="container">
      <template v-if="dataBarang">
        <!-- First Row -->
        <b-row>
          <b-col cols="12" lg="8">
            <barang-info-card :data-barang="dataBarang" />
          </b-col>
          <b-col cols="12" lg="4">
            <barang-harga-jual :data-barang="dataBarang" />
          </b-col>
        </b-row>
        <b-card>
          <b-card-body>
            <b-tabs pills>
              <b-tab title="Transaksi Penjualan" active>
                <table-transaksi-penjualan
                  :data-transaksi="transaksiPenjualan"
                  :data-temp="transaksiPenjualan"
                  :components="true"
                  :typeRetur="false"
                  :tanggalData="tanggal"
                />
              </b-tab>
              <b-tab title="Transaksi Pembelian">
                <table-transaksi-pembelian
                  :data-transaksi="transaksiPembelian"
                  :data-temp="transaksiPembelian"
                  :components="true"
                  :typeRetur="false"
                  :tanggalData="tanggal"
                />
              </b-tab>
              <b-tab title="Kartu Persediaan">
                <b-col cols="4" lg="4"
                  ><b-form-group label="Gudang" label-for="gudang">
                    <v-select v-model="gudang" :options="listGudang" label="nama" :clearable="false" /> </b-form-group
                ></b-col>

                <kartu-persediaan :list-data="dataPersediaan" />
              </b-tab>
            </b-tabs>
          </b-card-body>
        </b-card>
      </template>
    </div>
    <sidebar-add-harga />
    <sidebar-add-satuan />
  </section>
</template>

<script>
// import { ref } from '@vue/composition-api'

import store from '@/store'
import router from '@/router'
import {
  BRow,
  BCol,
  BTab,
  BTabs,
  BCard,
  BCardBody,
  BFormGroup,
  // BAlert,
  // BLink
} from 'bootstrap-vue'
import vSelect from 'vue-select'

import KartuPersediaan from '@/views/master/persediaan/component/KartuPersediaan.vue'
import TableTransaksiPenjualan from '@/views/transaksi/penjualan/component/TableTransaksiPenjualan.vue'
import TableTransaksiPembelian from '@/views/transaksi/pembelian/component/TableTransaksiPembelian.vue'

import BarangInfoCard from './BarangInfoCard.vue'
import BarangHargaJual from './BarangHargaJual.vue'
import SidebarAddHarga from '../Component/SidebarAddHarga.vue'
import SidebarAddSatuan from '../Component/SidebarAddSatuan.vue'

export default {
  components: {
    vSelect,
    TableTransaksiPenjualan,
    TableTransaksiPembelian,
    BRow,
    BCol,
    BCardBody,
    BCard,
    BFormGroup,
    // BAlert,
    // BLink,
    BTab,
    BTabs,
    KartuPersediaan,
    // KartuPersediaan,
    BarangInfoCard,
    BarangHargaJual,
    SidebarAddHarga,
    SidebarAddSatuan,
  },
  data() {
    return {
      listGudang: [],
      gudang: null,
      tanggal: {
        awal: '',
        akhir: '',
      },
      dataPersediaan: [],
      dataBarang: {
        kode_barang: '',
      },
      transaksiPenjualan: [],
      transaksiPembelian: [],
    }
  },
  watch: {
    gudang() {
      const { id } = router.currentRoute.params
      this.loadData(parseInt(id, 10))
    },
  },
  mounted() {
    this.loadGudang()
    this.loadMetaData()
  },
  methods: {
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
          this.gudang = this.listGudang.find(x => x.utama === 1)
        })
    },
    loadMetaData() {
      const { id } = router.currentRoute.params
      const loader = this.$loading.show({
        container: this.$refs.container,
      })
      store.dispatch('app-barang/fetchBarangById', { id }).then(res => {
        console.info('aa')
        this.dataBarang = res.data
        this.loadData()
        loader.hide()
      })
    },
    loadData() {
      const user = JSON.parse(localStorage.getItem('userData'))
      const cabang = user.cabang.id
      const idBarang = this.dataBarang.barang.id
      store.dispatch('app-persediaan/fetchKartuPersediaan', { id: idBarang, gudang_id: this.gudang.id }).then(res => {
        store.commit('app-persediaan/SET_KARTU_PERSEDIAAN', res.data)
        this.dataPersediaan = store.getters['app-persediaan/getKartuPersediaan']
      })
      store.dispatch('app-transaksi-penjualan/fetchListTransaksiByBarang', { idBarang, cabang }).then(res => {
        this.transaksiPenjualan = res.data
      })
      store.dispatch('app-transaksi-pembelian/fetchListTransaksiByBarang', { idBarang, cabang }).then(res => {
        this.transaksiPembelian = res.data
      })
    },
  },
}
</script>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
</style>
