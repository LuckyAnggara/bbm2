<template>
  <section>
    <b-row class="match-height">
      <b-col lg="12" cols="12">
        <b-card>
          <div class="mb-2">
            <!-- Table Top -->
            <b-row>
              <!-- Per Page -->
              <b-col cols="12" md="2">
                <label>Entries</label>
                <v-select v-model="perPage" :options="perPageOptions" :clearable="false" />
              </b-col>

              <b-col cols="12" md="2">
                <label>Filter Status</label>
                <v-select v-model="statusFilter" :options="filterOption" :clearable="true" />
              </b-col>

              <!-- Search -->
              <b-col cols="12" md="6" offset-lg="2">
                <label>Filter Status</label>
                <b-form-input v-model="searchQuery" placeholder="Cari data... (Kode P.O)" />
              </b-col>
            </b-row>
          </div>

          <b-table
            ref="refTable"
            responsive
            primary-key="id"
            :fields="tableColumns"
            :items="dataPO"
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
            <!-- Column: Id -->
            <template #cell(tanggal_po)="data">
              <span>
                {{ $moment(data.item.created_at).format('DD-MMM-YYYY') }}
              </span>
            </template>
            <!-- Column: Id -->
            <template #cell(jumlah_barang)="data">
              <span> {{ data.item.jumlah_barang }} Item </span>
            </template>
            <template #cell(status)="data">
              <div class="text-nowrap">
                <template>
                  <b-badge pill variant="light-warning" v-if="data.item.status === 'SEND'"> {{ data.item.status }} </b-badge>
                  <b-badge pill variant="light-primary" v-if="data.item.status === 'APPROVED'"> {{ data.item.status }} </b-badge>
                  <b-badge pill variant="light-success" v-if="data.item.status === 'SELESAI'"> {{ data.item.status }} </b-badge>
                  <b-badge pill variant="light-danger" v-if="data.item.status === 'REJECT'"> {{ data.item.status }} </b-badge>
                </template>
              </div>
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
                      name: 'transaksi-po-detail',
                      params: { id: data.item.id, data: data.item },
                    })
                  "
                />
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
        </b-card>
      </b-col>
    </b-row>
  </section>
</template>

<script>
import store from '@/store'
import { ref } from '@vue/composition-api'

import { BBadge, BCard, BRow, BCol, BFormInput, BTable, BPagination } from 'bootstrap-vue'
import vSelect from 'vue-select'

export default {
  components: {
    BBadge,
    BCard,
    BRow,
    BCol,
    BFormInput,
    BTable,
    BPagination,
    vSelect,
  },
  data() {
    return {
      filterQuery: '',
      searchQuery: '',
      refTable: null,
      dataPO: [],
      dataTemp: [],
    }
  },
  watch: {
    searchQuery(query) {
      if (query === '') {
        this.dataPO = this.dataTemp
      } else {
        this.dataPO = this.dataTemp.filter(item => item.kode_po.toLowerCase().indexOf(query) > -1)
      }
    },
    statusFilter(x) {
      if (x === null || x === '') {
        this.dataPO = this.dataTemp
      } else {
        this.dataPO = this.dataTemp.filter(item => item.status === x)
      }
    },
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
    totalData() {
      return this.dataPO.length
    },
  },
  methods: {
    loadData() {
      const user = JSON.parse(localStorage.getItem('userData'))
      store.dispatch('app-po/listPOMasuk', { cabang_id: user.cabang_id }).then(res => {
        store.commit('app-po/SET_LIST_PO_MASUK', res.data)
        this.dataTemp = store.getters['app-po/getListPOMasuk']
        this.dataPO = this.dataTemp
      })
    },
  },
  mounted() {
    this.loadData()
  },
  setup() {
    const tableColumns = [
      { key: 'id', label: '#', sortable: true },
      { key: 'tanggal_po', sortable: true },
      { key: 'kode_po', sortable: true },
      { key: 'jumlah_barang', sortable: true },
      { key: 'status', sortable: true },
      { key: 'actions' },
    ]

    // const searchQuery = ref('')
    const perPage = ref(10)
    const currentPage = ref(1)
    const perPageOptions = [10, 25, 50, 100]
    const sortBy = ref('id')
    const isSortDirDesc = ref(true)
    const filterOption = ref(['SEND', 'APPROVED', 'REJECT', 'SELESAI'])
    const statusFilter = ref(null)

    return {
      tableColumns,
      // searchQuery,
      filterOption,
      perPage,
      isSortDirDesc,
      currentPage,
      perPageOptions,
      sortBy,
      statusFilter,
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
