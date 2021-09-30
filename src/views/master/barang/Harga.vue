<template>
  <section>
    <b-row class="match-height">
      <b-col lg="9" cols="12">
        <!-- <card-statistics-group :data-barang="dataBarang" /> -->
      </b-col>
      <b-col lg="12" cols="12">
        <b-card>
          <b-col cols="12" md="6" class="mb-2">
            <b-button variant="primary" @click="proses">
              Proses
            </b-button>
          </b-col>
          <b-table ref="refTable" responsive :fields="tableColumns" :items="dataBarang" show-empty empty-text="Tidak ada data" class="position-relative">
            <!-- Column: Id -->
            <template #cell(id)="data">
              <span>
                {{ data.index + 1 }}
              </span>
            </template>
            <template #cell(harga_1)="data">
              <b-form-input v-model="data.item.harga_ritel" />
            </template>
            <template #cell(harga_2)="data">
              <b-form-input v-model="data.item.harga_konsumen" />
            </template>
            <template #cell(harga_3)="data">
              <b-form-input v-model="data.item.harga_lainnya" />
            </template>
          </b-table>
        </b-card>
      </b-col>
    </b-row>
  </section>
</template>

<script>
import store from '@/store'
import { ref } from '@vue/composition-api'
import { formatRupiah } from '@core/utils/filter'

import { BButton, BCard, BRow, BCol, BFormInput, BTable } from 'bootstrap-vue'

export default {
  components: {
    BButton,
    BCard,
    BRow,
    BCol,
    BTable,
    BFormInput,
  },

  methods: {
    formatRupiah,
    loadbarang() {
      store.dispatch('app-barang/fetchListBarang', { cabang_id: this.userData.cabang_id }).then(res => {
        store.commit('app-barang/SET_LIST_BARANG', res.data)
        this.dataBarang = store.getters['app-barang/getListBarang']
      })
    },
    proses() {
      this.$swal({
        title: 'Ubah data ?',
        text: 'Harga Barang akan di Ubah',
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
          this.$store.dispatch('app-barang/ubahHargaBarangSemua', { data: this.dataBarang }).then(res => {
            if (res.status === 200) {
              this.$swal({
                icon: 'success',
                title: 'Harga di Ubah!',
                customClass: {
                  confirmButton: 'btn btn-success',
                },
              })
              this.$router.push({
                name: 'master-barang-daftar',
              })
            }
          })
        }
      })
    },
  },
  mounted() {
    this.loadbarang()
  },
  setup() {
    const dataBarang = ref([])
    const tableColumns = [
      { key: 'id', label: '#', sortable: true },
      { key: 'kode_barang', sortable: true },
      { key: 'nama', label: 'Nama Barang', sortable: true },
      { key: 'harga_1', label: 'Harga Konsumen', sortable: true },
      { key: 'harga_2', label: 'Harga Ritel', sortable: true },
      { key: 'harga_3', label: 'Harga Lainnya', sortable: true },
    ]

    // const searchQuery = ref('')

    const userData = JSON.parse(localStorage.getItem('userData'))

    return {
      dataBarang,
      userData,
      tableColumns,
    }
  },
}
</script>

<style lang="scss" scoped>
.per-page-selector {
  width: 90px;
}

.barang-filter-select {
  min-width: 190px;

  ::v-deep .vs__selected-options {
    flex-wrap: nowrap;
  }

  ::v-deep .vs__selected {
    width: 100px;
  }
}
</style>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
</style>
