<template>
  <b-row>
    <b-col cols="12">
      <b-card>
        <b-card-body>
          <b-tabs pills>
            <b-tab title="Pelanggan" active>
              <tabel-component :data-kontak="kontak.filter(item => item.tipe === `PELANGGAN`)" />
            </b-tab>
            <b-tab title="Supplier">
              <tabel-component :data-kontak="kontak.filter(item => item.tipe === `SUPPLIER`)" />
            </b-tab>
          </b-tabs>
        </b-card-body>
      </b-card>
    </b-col>
  </b-row>
</template>

<script>
import { ref } from '@vue/composition-api'

import router from '@/router'
import { BRow, BCol, BCard, BCardBody, BTab, BTabs } from 'bootstrap-vue'
import store from '@/store'
import TabelComponent from './TabelComponent.vue'

export default {
  components: {
    TabelComponent,
    BTab,
    BTabs,
    BRow,
    BCol,

    // BDropdown,
    // BDropdownItem,
    BCard,
    BCardBody,
  },

  data() {
    return {
      pageLength: 5,
      dir: false,
    }
  },
  mounted() {
    this.loadData()
  },
  methods: {
    tipePelanggan(status) {
      const statusColor = {
        /* eslint-disable key-spacing */
        PELANGGAN: 'light-success',
        SUPPLIER: 'light-danger',
        KARYAWAN: 'light-warning',
        /* eslint-enable key-spacing */
      }

      return statusColor[status]
    },
    formatRupiah(value) {
      return `Rp. ${value.toFixed(0).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
    loadData() {
      store.dispatch('app-kontak/fetchListKontak').then(res => {
        store.commit('app-kontak/SET_LIST_KONTAK', res.data)
        this.kontak = store.getters['app-kontak/getListKontak']
      })
    },
    view(obj) {
      router.push({ name: 'master-barang-detail', params: { id: obj } })
    },
    edit(id) {
      return id
    },
    // del(id) {
    //   this.$swal({
    //     title: 'Delete data ?',
    //     text: 'Data barang akan di hapus',
    //     icon: 'warning',
    //     showCancelButton: true,
    //     confirmButtonText: 'Yes, delete it!',
    //     customClass: {
    //       confirmButton: 'btn btn-primary',
    //       cancelButton: 'btn btn-outline-danger ml-1',
    //     },
    //     buttonsStyling: false,
    //   }).then(result => {
    //     if (result.value) {
    //       axios.delete(`http://127.0.0.1:8000/api/barang/${id}`).then(res => {
    //         if (res.status === 200) {
    //           this.loadData()
    //           this.$swal({
    //             icon: 'success',
    //             title: 'Deleted!',
    //             customClass: {
    //               confirmButton: 'btn btn-success',
    //             },
    //           })
    //         }
    //       })
    //     }
    //   })
    // },
    toTambahScreen() {
      this.$router.push({
        name: 'master-kontak-tambah',
      })
    },
  },
  setup() {
    const kontak = ref([])
    return {
      kontak,
    }
  },
}
</script>
