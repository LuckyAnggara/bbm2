<template>
  <b-row>
    <b-col cols="12">
      <b-card>
        <b-card-body>
          <div class="mb-2">
            <!-- Table Top -->
            <b-row>
              <!-- Per Page -->
              <b-col cols="12" md="6" class="d-flex align-items-center justify-content-start mb-1 mb-md-0">
                <label>Data</label>
                <v-select v-model="perPage" :options="perPageOptions" :clearable="false" class="per-page-selector d-inline-block ml-50 mr-1" />
                <b-button variant="primary" :to="{ name: 'master-gudang-tambah' }">
                  Tambah
                </b-button>
              </b-col>

              <!-- Search -->
              <b-col cols="12" md="6">
                <div class="d-flex align-items-center justify-content-end">
                  <b-form-input v-model="searchQuery" class="d-inline-block mr-1" placeholder="Cari data... ( Nama Gudang )" />
                </div>
              </b-col>
            </b-row>
          </div>

          <b-table
            ref="refTable"
            responsive
            primary-key="id"
            :fields="tableColumns"
            :items="listGudang"
            :current-page="currentPage"
            :per-page="perPage"
            :sort-by.sync="sortBy"
            :sort-desc.sync="isSortDirDesc"
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

            <!-- Column: Utama -->
            <template #cell(nama)="data">
              {{ data.item.nama }}
              <b-badge variant="primary" v-if="data.item.utama === 1">
                Default
              </b-badge>
            </template>

            <!-- Column: Actions -->
            <template #cell(action)="data">
              <div class="text-nowrap">
                <feather-icon
                  :id="`gudang-row-${data.item.id}-detail`"
                  icon="EyeIcon"
                  size="16"
                  class="mx-1"
                  @click="
                    $router.push({
                      name: 'transaksi-penjualan-gudang',
                      params: { id: data.item.id },
                    })
                  "
                />

                <b-dropdown variant="link" toggle-class="p-0" no-caret :right="$store.state.appConfig.isRTL">
                  <template #button-content>
                    <feather-icon icon="MoreVerticalIcon" size="16" class="align-middle text-body" />
                  </template>
                  <b-dropdown-item>
                    <feather-icon icon="TrashIcon" />
                    <span class="align-middle ml-50">Delete</span>
                  </b-dropdown-item>
                </b-dropdown>
              </div>
            </template>
          </b-table>
          <div class="mx-2 mb-2">
            <b-row>
              <b-col cols="12" sm="6" class="d-flex align-items-center justify-content-center justify-content-sm-start">
                <span class="text-muted">Showing {{ dataMeta.from }} to {{ dataMeta.to }} of {{ dataMeta.of }} entries</span>
              </b-col>
              <!-- Pagination -->
              <b-col cols="12" sm="6" class="d-flex align-items-center justify-content-center justify-content-sm-end">
                <b-pagination
                  v-model="currentPage"
                  :total-rows="totalData"
                  :per-page="perPage"
                  first-number
                  last-number
                  class="mb-0 mt-1 mt-sm-0"
                  prev-class="prev-item"
                  next-class="next-item"
                >
                  <template #prev-text>
                    <feather-icon icon="ChevronLeftIcon" size="18" />
                  </template>
                  <template #next-text>
                    <feather-icon icon="ChevronRightIcon" size="18" />
                  </template>
                </b-pagination>
              </b-col>
            </b-row>
          </div>
        </b-card-body>
      </b-card>
    </b-col>
  </b-row>
</template>

<script>
import { ref } from '@vue/composition-api'

import router from '@/router'
import { BBadge, BRow, BCol, BCard, BCardBody, BFormInput, BButton, BTable, BPagination, BDropdown, BDropdownItem } from 'bootstrap-vue'
import store from '@/store'
import vSelect from 'vue-select'

export default {
  components: {
    BBadge,
    BRow,
    BCol,
    BFormInput,
    BButton,
    BTable,
    BPagination,
    BDropdown,
    BDropdownItem,
    vSelect,

    // BDropdown,
    // BDropdownItem,
    BCard,
    BCardBody,
  },
  computed: {
    dataMeta() {
      const localItemsCount = this.$refs.refTable ? this.$refs.refTable.computedItems.length : 0
      return {
        from: this.perPage * (this.currentPage - 1) + (localItemsCount ? 1 : 0),
        to: this.perPage * (this.currentPage - 1) + localItemsCount,
        of: this.totalData,
      }
    },
  },
  data() {
    return {
      pageLength: 5,
      dir: false,
      data: [],
      searchQuery: '',
      refTable: null,
    }
  },
  watch: {
    searchQuery(query) {
      if (query === '') {
        this.gudang = this.data
      } else {
        this.gudang = this.data.filter(item => item.nama.toLowerCase().indexOf(query.toLowerCase()) > -1)
      }
      this.totalData = this.gudang.length
    },
    datagudang() {
      this.gudang = this.datagudang
      this.data = this.datagudang
      this.totalData = this.datagudang.length
    },
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
      store.dispatch('app-gudang/fetchListGudang', { cabang: 0 }).then(res => {
        store.commit('app-gudang/SET_LIST_GUDANG', res.data)
        this.listGudang = store.getters['app-gudang/getListGudang']
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
        name: 'master-gudang-tambah',
      })
    },
  },
  setup() {
    const listGudang = ref([])

    const tableColumns = [
      { key: 'id', label: '#', sortable: true },
      { key: 'nama', sortable: true },
      { key: 'alamat', sortable: true },
      { label: 'cabang', key: 'nama_cabang', sortable: true },
      { key: 'action' },
    ]
    // const searchQuery = ref('')
    const perPage = ref(10)
    const totalData = ref(0)
    const currentPage = ref(1)
    const perPageOptions = [10, 25, 50, 100]
    const sortBy = ref('id')
    const isSortDirDesc = ref(true)
    const statusFilter = ref(null)

    return {
      tableColumns,
      // searchQuery,
      perPage,
      isSortDirDesc,
      currentPage,
      totalData,
      perPageOptions,
      sortBy,
      statusFilter,
      listGudang,
    }
  },
}
</script>

<style lang="scss" scoped>
.per-page-selector {
  width: 90px;
}

.gudang-filter-select {
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
