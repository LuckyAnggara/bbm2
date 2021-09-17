<template>
  <section>
    <b-card title="Data Transaksi Penjualan Hari ini">
      <b-table
        primary-key="id"
        ref="refTable"
        :fields="tableColumns"
        :items="dataTransaksi"
        :current-page="currentPage"
        :per-page="perPage"
        :sort-by.sync="sortBy"
        :sort-desc.sync="isSortDirDesc"
        show-empty
        empty-text="Tidak ada data"
        responsive
      >
        <!-- Column: Id -->
        <template #cell(id)="data">
          <span>
            {{ data.index + 1 }}
          </span>
        </template>

        <!-- Column: Nomor Transaksi -->
        <template #cell(nomorTransaksi)="data">
          <b-link :to="{ name: 'transaksi-penjualan-invoice', params: { id: data.item.id } }" class="font-weight-bold"> {{ data.item.nomorTransaksi }} </b-link>
        </template>

        <!-- Column: Nama Pelanggan -->
        <template #cell(namaPelanggan)="data">
          <span>
            {{ data.item.pelanggan.nama }}
          </span>
        </template>

        <!-- Column: Total -->
        <template #cell(total)="data">
          <span class="text-nowrap">
            {{ formatRupiah(data.item.invoice.grandTotal) }}
          </span>
        </template>

        <!-- Column: Balance -->
        <template #cell(saldo)="data">
          <div class="text-nowrap">
            <template v-if="data.item.pembayaran.sisaPembayaran === null || data.item.pembayaran.sisaPembayaran === 0">
              <b-badge pill variant="light-success">
                Lunas
              </b-badge>
            </template>
            <template v-else>
              <b-badge pill variant="light-danger">
                <span class="text-danger" :id="`transaksi-row-${data.item.id}-tooltip-saldo`">-{{ formatRupiah(data.item.pembayaran.sisaPembayaran) }}</span>
              </b-badge>
              <b-tooltip :target="`transaksi-row-${data.item.id}-tooltip-saldo`">
                <span v-if="data.item.pembayaran.statusPembayaran.value === 1">
                  Kredit
                  <br />
                  Jt. Tempo : {{ moment(data.item.pembayaran.tanggalJatuhTempo) }}
                  <br />
                  Total Tagihan : {{ data.item.pembayaran.sisaPembayaran }}
                </span>
                <span v-else-if="data.item.pembayaran.statusPembayaran.value === 2">
                  Cash On Delivery
                  <br />
                  Total Tagihan : {{ data.item.pembayaran.sisaPembayaran }}
                </span>
              </b-tooltip>
            </template>
          </div>
        </template>

        <!-- Column: Maker -->
        <template #cell(sales)="data">
          <span>
            {{ data.item.sales === null ? '-' : data.item.sales.nama }}
          </span>
        </template>

        <!-- Column: Maker -->
        <template #cell(maker)="data">
          <span>
            {{ data.item.user.nama }}
          </span>
        </template>

        <!-- Column: Actions -->
        <template #cell(actions)="data">
          <div class="text-nowrap">
            <feather-icon
              :id="`invoice-row-${data.item.id}-preview-icon`"
              icon="EyeIcon"
              size="16"
              class="mx-1"
              @click="
                $router.push({
                  name: 'transaksi-penjualan-invoice',
                  params: { id: data.item.id },
                })
              "
            />
            <b-tooltip title="Preview Invoice" :target="`invoice-row-${data.item.id}-preview-icon`" />
          </div>
        </template>
      </b-table>
      <div class="mx-2 mb-2">
        <b-row>
          <b-col cols="12" sm="6" class="d-flex align-items-center justify-content-center justify-content-sm-start">
            <span class="text-muted">Showing {{ dataMeta.from }} to {{ dataMeta.to }} of {{ dataMeta.of }} Transaksi</span>
          </b-col>
          <!-- Pagination -->
          <b-col cols="12" sm="6" class="d-flex align-items-center justify-content-center justify-content-sm-end">
            <b-pagination
              v-model="currentPage"
              :total-rows="totalInvoices"
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
  </section>
</template>

<script>
import { ref } from '@vue/composition-api'

import { BCard, BRow, BCol, BTable, BLink, BBadge, BPagination, BTooltip } from 'bootstrap-vue'

export default {
  components: {
    BCard,
    BRow,
    BCol,
    BTable,
    BLink,
    BBadge,

    BPagination,
    BTooltip,
  },
  data() {
    return {
      refTable: null,
      tanggalData: {
        awal: new Date(),
        akhir: new Date(),
      },
    }
  },
  props: {
    dataTransaksi: {
      type: Array,
      required: true,
    },
  },
  computed: {
    tanggal() {
      return {
        awal: this.$moment(this.tanggalData.awal).format('DD MMMM YYYY'),
        akhir: this.$moment(this.tanggalData.akhir).format('DD MMMM YYYY'),
      }
    },
    dataMeta() {
      const localItemsCount = this.$refs.refTable ? this.$refs.refTable.computedItems.length : 0
      return {
        from: this.perPage * (this.currentPage - 1) + (localItemsCount ? 1 : 0),
        to: this.perPage * (this.currentPage - 1) + localItemsCount,
        of: this.totalInvoices,
      }
    },
    totalInvoices() {
      return this.dataTransaksi.length
    },
  },
  methods: {
    moment(value) {
      return this.$moment(value).format('DD MMMM YYYY')
    },
    formatRupiah(value) {
      return `Rp. ${value.toFixed(0).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
  },
  setup() {
    const tableColumns = [
      { key: 'id', label: '#', sortable: true },
      { key: 'nomorTransaksi', sortable: true },
      { key: 'namaPelanggan', sortable: true },
      { key: 'total', sortable: true },
      { key: 'saldo', sortable: true },
      { key: 'sales', sortable: true },
      { key: 'maker', sortable: true },
      { key: 'actions' },
    ]

    const perPage = ref(10)
    const currentPage = ref(1)
    const perPageOptions = [10, 25, 50, 100]
    const sortBy = ref('id')
    const isSortDirDesc = ref(true)
    const statusFilter = ref(null)

    return {
      tableColumns,
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
</style>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
@import '@core/scss/vue/libs/vue-flatpicker.scss';
</style>
