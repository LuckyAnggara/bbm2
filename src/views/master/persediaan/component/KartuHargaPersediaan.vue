<template>
  <section>
    <div class="mb-2">
      <!-- Table Top -->
      <b-row>
        <!-- Per Page -->
        <b-col cols="12" md="6" class="d-flex align-items-center justify-content-start mb-1 mb-md-0">
          <label>Data</label>
          <v-select v-model="perPage" :options="perPageOptions" :clearable="false" class="per-page-selector d-inline-block ml-50 mr-1" />
        </b-col>
        <!-- Search -->
        <b-col cols="12" md="6">
          <span> {{ dataHargaPersediaan.kode_barang }} - {{ dataHargaPersediaan.nama }}</span> <br />
          <span> Total : {{ formatRupiah(dataHargaPersediaan.persediaan.saldo_rp) }}</span>
        </b-col>
      </b-row>
    </div>

    <b-table
      ref="refTable"
      responsive
      primary-key="id"
      show-empty
      empty-text="Tidak ada data"
      class="position-relative"
      :items="dataHargaPersediaan.persediaan.harga_beli"
      :fields="tableColumns"
      :current-page="currentPage"
      :per-page="perPage"
      :sort-by.sync="sortBy"
      :sort-desc.sync="isSortDirDesc"
    >
      <!-- Column: Nomor -->
      <template #cell(tanggal_transaksi)="data">
        <span>
          {{ moment(data.item.created_at) }}
        </span>
      </template>

      <!-- Column: Harga Beli -->
      <template #cell(harga_beli)="data">
        <span class="font-weight-bold">
          {{ data.item.harga_beli ? formatRupiah(data.item.harga_beli) : '-' }}
        </span>
      </template>

      <!-- Column: DEBIT -->
      <template #cell(saldo)="data">
        <span>
          {{ data.item.saldo }}
        </span>
      </template>

      <!-- Column: Harga Beli -->
      <template #cell(total)="data">
        <span class="font-weight-bold">
          {{ data.item.total ? formatRupiah(data.item.total) : '-' }}
        </span>
      </template>
    </b-table>
    <div class="mx-2 mb-2">
      <b-row>
        <b-col cols="12" sm="6" class="d-flex align-items-center justify-content-center justify-content-sm-start">
          <span class="text-muted">Showing {{ dataMeta.from }} to {{ dataMeta.to }} of {{ dataMeta.of }} entries</span>
        </b-col>
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

    <div class="mx-2 mb-2">
      <span class="text-muted"
        >Urutan paling atas adalah barang masuk yang terbaru <br />
        Barang dengan saldo 0 tidak di tampilkan</span
      >
    </div>
  </section>
</template>

<script>
import { BRow, BCol, BPagination, BTable } from 'bootstrap-vue'
import { ref } from '@vue/composition-api'

import Ripple from 'vue-ripple-directive'
import vSelect from 'vue-select'

export default {
  components: {
    BTable,
    BRow,
    BCol,
    BPagination,
    vSelect,
  },
  directives: {
    Ripple,
  },
  props: {
    dataHargaPersediaan: Object,
  },
  data() {
    return {
      date: {
        value: Date.now(),
        config: {
          wrap: true, // set wrap to true only when using 'input-group'
          altFormat: 'd F Y',
          altInput: true,
          dateFormat: 'Y-m-d',
          mode: 'range',
        },
      },
      filterQuery: '',
      searchQuery: '',
      refTable: null,
    }
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
      return this.dataHargaPersediaan.length
    },
  },
  methods: {
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
    moment(value) {
      return this.$moment(value).format('DD MMMM YYYY')
    },
  },
  setup() {
    const tableColumns = [
      { key: 'tanggal_transaksi', sortable: false },
      { key: 'harga_beli', sortable: false },
      { key: 'saldo', sortable: false },
      { key: 'total', sortable: false },
    ]
    const perPage = ref(10)

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
      perPageOptions,
      sortBy,
      statusFilter,
    }
  },
}
</script>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
</style>
