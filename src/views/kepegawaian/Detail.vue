<template>
  <section>
    <div ref="container">
      <template>
        <b-row>
          <b-col lg="3" cols="12">
            <b-card title="Lucky Anggara" sub-title="IT Support">
              <b-img fluid class="mb-2" :src="require('@/assets/images/slider/06.jpg')" />
            </b-card>
          </b-col>
          <b-col lg="9" cols="12">
            <b-card>
              <b-tabs pills>
                <b-tab title="Data Diri" active> <data-diri :data-diri="dataPegawai" /> </b-tab>
                <b-tab title="Data Presensi" lazy> <data-presensi /></b-tab>
                <b-tab title="Data Performance"> </b-tab>
              </b-tabs>
            </b-card>
          </b-col>
        </b-row>
      </template>
    </div>
  </section>
</template>

<script>
import store from '@/store'

import { BImg, BRow, BCol, BTab, BTabs, BCard } from 'bootstrap-vue'

import DataDiri from './component/DataDiri.vue'
import DataPresensi from './component/DataPresensi.vue'

export default {
  components: {
    DataDiri,
    DataPresensi,
    BImg,
    BRow,
    BCol,
    BCard,
    BTab,
    BTabs,
  },
  data() {
    return {
      dataPegawai: {},
    }
  },
  methods: {
    setData() {
      const { id } = this.$router.currentRoute.params
      store.commit('app-pegawai/SET_DETAIL_DATA', parseInt(id, 10))
      this.dataPegawai = store.getters['app-pegawai/getDetailData']
      store.dispatch('app-pegawai/fetchListPresensi', id).then(res => {
        if (res.status === 200) {
          store.commit('app-pegawai/SET_DETAIL_PRESENSI', res.data)
        }
      })
    },
    loadpegawai() {
      store.dispatch('app-pegawai/fetchListPegawai').then(res => {
        if (res.status === 200) {
          store.commit('app-pegawai/SET_LIST_PEGAWAI', res.data)
          this.setData()
        }
      })
    },
  },
  mounted() {
    if (store.getters['app-pegawai/getListPegawai'].length === 0) {
      this.loadpegawai()
      return
    }
    this.setData()
  },
}
</script>

<style></style>
