<template>
  <b-row>
    <b-col cols="12">
      <b-card>
        <b-card-header class="pb-50">
          <h4>
            Data Draft Transaksi Penjualan
          </h4>
        </b-card-header>
        <b-card-body>
          <div class="mb-2">
            <!-- Table Top -->
            <b-row>
              <!-- Per Page -->
              <b-col cols="12" md="6" class="d-flex align-items-center justify-content-start mb-1 mb-md-0">
                <b-button variant="primary" :to="{ name: 'transaksi-penjualan-tambah' }" class="d-inline-block ml-50 mr-1">
                  Tambah Data
                </b-button>
              </b-col>
            </b-row>
          </div>
          <b-table
            id="my-table"
            ref="refTable"
            primary-key="id"
            :fields="tableColumns"
            :items="listDraft"
            show-empty
            empty-text="Tidak ada data"
            class="position-relative"
          >
            <!-- Column: Id -->
            <template #cell(id)="data">
              <span>
                {{ data.index + 1 }}
              </span>
            </template>

            <!-- Column: Nama Pelanggan -->
            <template #cell(nama_pelanggan)="data">
              <span>
                {{ data.item.pelanggan.nama }}
              </span>
            </template>

            <!-- Column: Jumlah Item -->
            <template #cell(jumlah_item)="data">
              <span>
                {{ data.item.orders.length }}
              </span>
            </template>

            <!-- Column: Jumlah Item -->
            <template #cell(total)="data">
              <span>
                {{ formatRupiah(data.item.invoice.grandTotal) }}
              </span>
            </template>

            <!-- Column: Actions -->
            <template #cell(actions)="data">
              <div class="text-nowrap">
                <feather-icon
                  icon="EyeIcon"
                  size="16"
                  class="mx-1"
                  @click="
                    $router.push({
                      name: 'transaksi-penjualan-tambah',
                      params: {
                        id: data.index,
                      },
                    })
                  "
                />

                <b-dropdown variant="link" toggle-class="p-0" no-caret>
                  <template #button-content>
                    <feather-icon icon="MoreVerticalIcon" size="16" class="align-middle text-body" />
                  </template>
                  <b-dropdown-item @click="del(data.index)">
                    <feather-icon icon="TrashIcon" />
                    <span class="align-middle ml-50">Delete</span>
                  </b-dropdown-item>
                </b-dropdown>
              </div>
            </template>
          </b-table>
        </b-card-body>
      </b-card>
    </b-col>
  </b-row>
</template>

<script>
import { ref } from '@vue/composition-api'

import { BTable, BRow, BCol, BButton, BCard, BCardHeader, BCardBody, BDropdown, BDropdownItem } from 'bootstrap-vue'
import Ripple from 'vue-ripple-directive'
import store from '@/store'

export default {
  components: {
    BTable,
    BDropdown,
    BDropdownItem,
    BRow,
    BCol,
    BButton,
    BCard,
    BCardHeader,
    BCardBody,
  },
  directives: {
    Ripple,
  },
  data() {
    return {}
  },
  mounted() {
    this.loadData()
  },
  methods: {
    del(index) {
      this.$swal({
        title: 'Delete ?',
        text: 'Draft Penjualan akan di Hapus',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes, delete it!',
        customClass: {
          confirmButton: 'btn btn-primary',
          cancelButton: 'btn btn-outline-danger ml-1',
        },
        buttonsStyling: false,
      }).then(result => {
        if (result.value) {
          store.commit('app-transaksi-penjualan/REMOVE_DRAFT_PENJUALAN', index)
          this.$swal({
            icon: 'success',
            title: 'Deleted!',
            customClass: {
              confirmButton: 'btn btn-success',
            },
          })
        }
      })
    },
    loadData() {
      this.listDraft = store.getters['app-transaksi-penjualan/getListDraftPenjualan']
    },
    formatDate(value) {
      return this.$moment(value).format('DD MMMM YYYY')
    },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
  },
  setup() {
    const listDraft = ref([])
    const tableColumns = [
      { key: 'id', label: '#', sortable: true },
      { key: 'nama_pelanggan', sortable: true },
      { key: 'jumlah_item', sortable: true },
      { key: 'total', sortable: true },
      { key: 'actions' },
    ]

    const perPage = ref(10)
    const totalDraft = ref(0)
    const currentPage = ref(1)
    const perPageOptions = [10, 25, 50, 100]
    const sortBy = ref('id')
    const isSortDirDesc = ref(true)
    const statusFilter = ref(null)

    return {
      listDraft,
      tableColumns,
      perPage,
      isSortDirDesc,
      currentPage,
      totalDraft,
      perPageOptions,
      sortBy,
      statusFilter,
    }
  },
}
</script>

<style lang="scss">
@import '@core/scss/vue/libs/vue-good-table.scss';
</style>
