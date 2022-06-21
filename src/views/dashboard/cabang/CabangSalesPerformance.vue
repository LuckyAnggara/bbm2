<template>
  <b-card v-if="dataPerformance.length > 0 ? true : false" class="card-transaction" no-body>
    <b-card-header>
      <b-card-title>Performance Sales</b-card-title>

      <b-dropdown variant="link" no-caret class="chart-dropdown" toggle-class="p-0" right>
        <template #button-content>
          <feather-icon icon="MoreVerticalIcon" size="18" class="text-body cursor-pointer" />
        </template>
        <b-dropdown-item href="#">
          Hari Ini
        </b-dropdown-item>
        <b-dropdown-item href="#">
          Bulan Ini
        </b-dropdown-item>
        <b-dropdown-item href="#">
          Tahun Ini
        </b-dropdown-item>
      </b-dropdown>
    </b-card-header>

    <b-card-body>
      <b-table
        ref="refTable"
        :busy="isBusy"
        :fields="tableColumns"
        :items="dataPerformance"
        :current-page="currentPage"
        per-page="5"
        show-empty
        empty-text="Tidak ada data"
        responsive
      >
        <template #table-busy>
          <div class="text-center text-danger my-2">
            <b-spinner class="align-middle"></b-spinner>
            <strong>Mohon tunggu...</strong>
          </div>
        </template>
        <!-- Column: Total Penjualan -->
        <template #cell(total_penjualan)="data">
          <span>
            {{ formatRupiah(data.item.total_penjualan) }}
          </span>
        </template>
      </b-table>
      <div class="mx-2 mb-2">
        <b-row>
          <!-- Pagination -->
          <b-col cols="12" sm="6" class="d-flex align-items-center justify-content-center justify-content-sm-end">
            <b-pagination
              v-model="currentPage"
              :total-rows="totalSales"
              per-page="5"
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
</template>

<script>
import { ref } from '@vue/composition-api'
import { BSpinner, BCol, BRow, BCard, BCardHeader, BCardTitle, BCardBody, BDropdown, BDropdownItem, BTable, BPagination } from 'bootstrap-vue'
import { formatRupiah } from '@core/utils/filter'

export default {
  components: {
    BSpinner,
    BCol,
    BRow,
    BCard,
    BCardHeader,
    BCardTitle,
    BCardBody,
    BDropdown,
    BDropdownItem,
    BTable,
    BPagination,
  },

  computed: {
    dataMeta() {
      const localItemsCount = this.$refs.refTable ? this.$refs.refTable.computedItems.length : 0
      return {
        from: 5 * (this.currentPage - 1) + (localItemsCount ? 1 : 0),
        to: 5 * (this.currentPage - 1) + localItemsCount,
        of: this.totalSales,
      }
    },
    totalSales() {
      return this.dataPerformance.length
    },
  },
  mounted() {
    this.loadData()
  },
  methods: {
    formatRupiah,
    loadData() {
      this.isBusy = !this.isBusy
      this.$store
        .dispatch('app-dashboard-cabang/fetchAllPerformanceSales', {
          cabang_id: this.userData.cabang_id,
          tahun: this.tahun,
          bulan: this.bulan,
          hari: this.$moment(this.hari).format('YYYY-M-D'),
        })
        .then(res => {
          this.isBusy = !this.isBusy
          this.dataPerformance = res.data
        })
    },
    tahunChange() {
      this.hari = ''
      this.bulan = ''
      this.tahun = new Date().getFullYear()
      this.title = `Performance Sales ${this.cabang.nama} Tahun ${this.tahun}`
      this.loadData()
    },
    bulanChange() {
      this.hari = ''
      this.tahun = ''
      this.bulan = new Date().getMonth()
      this.title = `Performance Sales ${this.cabang.nama} Bulan ${this.bulan.title}`
      this.loadDataSemua()
    },
    hariChange() {
      this.tahun = ''
      this.bulan = ''
      this.hari = new Date()
      this.title = `Performance Sales ${this.cabang.nama} Tanggal ${this.$moment(this.hari).format('LL')}`
      this.loadDataSemua()
    },
  },
  setup() {
    const userData = JSON.parse(localStorage.getItem('userData'))
    const isBusy = false
    const title = ''
    const hari = new Date()
    const tahun = ''
    const bulan = ''
    const dataPerformance = ref([])
    const tableColumns = [
      { key: 'nama', sortable: true },
      { key: 'total_penjualan', sortable: true },
    ]
    const currentPage = ref(1)
    const perPageOptions = [10, 25, 50, 100]
    const isSortDirDesc = ref(true)
    const statusFilter = ref(null)

    return {
      userData,
      isBusy,
      title,
      hari,
      bulan,
      tahun,
      dataPerformance,
      tableColumns,
      isSortDirDesc,
      currentPage,
      perPageOptions,
      statusFilter,
    }
  },
}
</script>
