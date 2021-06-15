<template>
  <section>
    <div ref="container">
      <template>
        <b-row>
          <b-col lg="3" cols="12">
            <b-card title="Lucky Anggara" sub-title="IT Support">
              <b-img fluid class="mb-2" :src="require('@/assets/images/slider/06.jpg')" />
              <b-button v-ripple.400="'rgba(113, 102, 240, 0.15)'" :variant="color" @click="editProfile()">
                {{ title }}
              </b-button>
            </b-card>
          </b-col>
          <b-col lg="9" cols="12">
            <b-card>
              <b-tabs pills>
                <b-tab title="Data Pegawai" active lazy> <data-diri :data-diri="dataPegawai" :edit="readonly" /> </b-tab>
                <b-tab title="Data Presensi" lazy v-show="readonly"> <data-presensi /></b-tab>
                <b-tab title="Data Performance" v-show="readonly"> </b-tab>
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

import { BButton, BImg, BRow, BCol, BTab, BTabs, BCard } from 'bootstrap-vue'
import Ripple from 'vue-ripple-directive'

import DataDiri from './component/DataPegawai.vue'
import DataPresensi from './component/DataPresensi.vue'

export default {
  components: {
    DataDiri,
    DataPresensi,
    BButton,
    BImg,
    BRow,
    BCol,
    BCard,
    BTab,
    BTabs,
  },
  directives: {
    Ripple,
  },
  data() {
    return {
      dataPegawai: {},
      readonly: true,
      title: 'Edit Profile',
      color: 'outline-primary',
    }
  },
  methods: {
    editProfile() {
      if (this.title === 'Edit Profile') {
        this.readonly = false
        this.title = 'Simpan Perubahan'
        this.color = 'outline-success'
      } else {
        this.simpanProfile()
      }
    },
    simpanProfile() {
      this.$swal({
        title: 'Update',
        text: 'Apa anda yakin ?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Ya!',
        customClass: {
          confirmButton: 'btn btn-primary',
          cancelButton: 'btn btn-outline-danger ml-1',
        },
        buttonsStyling: false,
      }).then(result => {
        if (result.value) {
          store.dispatch('app-pegawai/editPegawai', { id: this.dataPegawai.id, data: this.dataPegawai }).then(res => {
            if (res.status === 200) {
              this.$swal({
                title: 'Success!',
                text: 'Update Sukses!!',
                icon: 'success',
                customClass: {
                  confirmButton: 'btn btn-primary',
                },
                buttonsStyling: false,
              })
              this.readonly = true
              this.title = 'Edit Profile'
              this.color = 'outline-primary'
            }
          })
        }
      })
    },
    setData() {
      const { id } = this.$router.currentRoute.params
      store.commit('app-pegawai/SET_DETAIL_DATA', parseInt(id, 10))
      this.dataPegawai = store.getters['app-pegawai/getDetailData']
      store.dispatch('app-pegawai/fetchDetailPresensi', id).then(res => {
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
          console.info(this.dataPegawai)
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
