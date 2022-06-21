<template>
  <section>
    <b-row class="match-height">
      <b-col lg="3" cols="12">
        <b-card>
          <b-form-group>
            <h5>Filter</h5>
            <hr />
            <h6 class="mb-1">Tanggal Transaksi</h6>
            <b-input-group>
              <flat-pickr v-model="date.value" class="form-control" :config="date.config" placeholder="Filter By Tanggal" />
              <!-- <b-form-datepicker v-model="tanggalFilter" locale="id" :date-format-options="{ year: 'numeric', month: 'numeric', day: 'numeric' }" /> -->
              <b-input-group-append>
                <b-button variant="outline-primary">
                  Clear
                </b-button>
              </b-input-group-append>
            </b-input-group>
          </b-form-group>
        </b-card>
      </b-col>
      <b-col lg="3" cols="12">
        <b-card>
          <b-form-group>
            <h5>Filter</h5>
            <hr />
            <h6 class="mb-1">Pelanggan</h6>
            <v-select v-model="pelanggan" placeholder="Cara Pembayaran" label="nama" :clearable="true" :options="listPelanggan" />
          </b-form-group>
        </b-card>
      </b-col>
      <b-col lg="6" cols="12">
        <b-card title="Statistik Piutang">
          <b-card-body>
            <b-row>
              <b-col md="5" sm="6" class="mb-2 mb-md-0 mb-xl-0">
                <b-media no-body>
                  <b-media-aside class="">
                    <b-avatar size="48" variant="light-info">
                      <feather-icon size="24" icon="ShoppingBagIcon" />
                    </b-avatar>
                  </b-media-aside>
                  <b-media-body class="my-auto">
                    <h4 class="font-weight-bolder mb-0">{{ totalData }} Trx</h4>
                    <b-card-text class="font-small-3 mb-0">
                      Jumlah Transaksi
                    </b-card-text>
                  </b-media-body>
                </b-media>
              </b-col>
              <b-col md="7" sm="6" class="mb-2 mb-md-0 mb-xl-0">
                <b-media no-body>
                  <b-media-aside class="">
                    <b-avatar size="48" variant="light-danger">
                      <feather-icon size="24" icon="BoxIcon" />
                    </b-avatar>
                  </b-media-aside>
                  <b-media-body class="my-auto">
                    <h4 class="font-weight-bolder mb-0">{{ formatRupiah(totalTagihan) }}</h4>
                    <b-card-text class="font-small-3 mb-0"> Total Tagihan </b-card-text>
                  </b-media-body>
                </b-media>
              </b-col>
            </b-row>
          </b-card-body>
        </b-card>
      </b-col>
      <b-col lg="12" cols="12">
        <b-card title="Data Piutang">
          <div class="mb-2">
            <!-- Table Top -->
            <b-row>
              <b-col cols="12" md="8" class="d-flex align-items-center justify-content-start mb-1 mb-md-0">
                <label class="mr-2">Entries</label>
                <v-select v-model="perPage" :options="perPageOptions" :clearable="false" class=" mr-1" />
                <label class="mr-2">Status</label>
                <v-select
                  class="mr-2"
                  :clearable="false"
                  v-model="statusFilter"
                  :options="[
                    { label: 'Semua', value: 0 },
                    { label: 'Lunas', value: 1 },
                    { label: 'Belum Lunas', value: 2 },
                  ]"
                />
                <b-button variant="primary" class=" mr-1">
                  Download
                </b-button>
                <!-- <b-button variant="success" @click="showBulkPembayaran()">
                  Bulk Pembayaran
                </b-button> -->
                <b-button variant="success" :to="{ name: 'keuangan-bulk-pembayaran-piutang', params: { pelanggan: listPelanggan } }">
                  Bulk Pembayaran
                </b-button>
              </b-col>
              <!-- Search -->
              <b-col cols="12" md="4">
                <div class="d-flex align-items-center justify-content-end">
                  <b-form-input v-model="searchQuery" class="d-inline-block mr-1" placeholder="" />
                </div>
              </b-col>
            </b-row>
          </div>

          <b-table
            ref="refTable"
            responsive
            :fields="tableColumns"
            :items="listData"
            :current-page="currentPage"
            :per-page="perPage"
            show-empty
            :sort-by.sync="sortBy"
            :sort-desc.sync="isSortDirDesc"
            class="position-relative"
          >
            <!-- Column: Id -->
            <template #cell(id)="data">
              <span>
                {{ data.index + 1 }}
              </span>
            </template>
            <!-- Column: Issued Date -->
            <template #cell(tanggal)="data">
              <span class="text-nowrap">
                {{ $moment(data.item.created_at).format('DD MMMM Y') }}
              </span>
            </template>
            <!-- Column: Nomor Transaksi -->
            <template #cell(nomor_transaksi)="data">
              <b-link :to="{ name: 'transaksi-penjualan-invoice', params: { id: data.item.id } }" class="font-weight-bold">
                #{{ data.item.nomor_transaksi }}
              </b-link>
            </template>

            <!-- Column: Total -->
            <template #cell(total)="data">
              <span class="text-nowrap">
                {{ formatRupiah(data.item.grand_total) }}
              </span>
            </template>

            <!-- Column: Total -->
            <template #cell(pembayaran)="data">
              <b-link class="text-nowrap" @click="showModalPembayaran(data.item)">
                {{ formatRupiah(parseFloat(data.item.grand_total) - parseFloat(data.item.sisa_pembayaran)) }}
              </b-link>
            </template>

            <!-- Column: Balance -->
            <template #cell(sisa_saldo)="data">
              <div class="text-nowrap">
                <template v-if="data.item.sisa_pembayaran === null || data.item.sisa_pembayaran === 0">
                  <b-badge pill variant="light-success">
                    Lunas
                  </b-badge>
                </template>
                <template v-else>
                  <b-badge pill variant="light-danger">
                    <span>{{ formatRupiah(data.item.sisa_pembayaran) }}</span>
                  </b-badge>
                </template>
              </div>
            </template>

            <!-- Column: Balance -->
            <template #cell(jatuh_tempo)="data">
              <div class="text-nowrap">
                <template v-if="data.item.sisa_pembayaran === null || data.item.sisa_pembayaran === 0">
                  <b-badge pill variant="success">
                    {{ $moment(data.item.tanggal_jatuh_tempo).format('DD MMMM Y') }}
                  </b-badge>
                </template>
                <template v-else>
                  <b-badge pill :variant="cekJatuhTempo(data.item)">
                    {{ $moment(data.item.tanggal_jatuh_tempo).format('DD MMMM Y') }}
                  </b-badge>
                </template>
              </div>
            </template>

            <!-- Column: Actions -->
            <template #cell(action)="data">
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
                <b-dropdown variant="link" toggle-class="p-0" no-caret>
                  <template #button-content>
                    <feather-icon icon="MoreVerticalIcon" size="16" class="align-middle text-body" />
                  </template>

                  <b-dropdown-item @click="showModalPembayaran(data.item)">
                    <feather-icon icon="ActivityIcon" />
                    <span class="align-middle ml-50">Pembayaran</span>
                  </b-dropdown-item>
                  <b-dropdown-item :to="{ name: 'akuntansi-jurnal-detail', params: { id: data.item.nomor_jurnal } }">
                    <feather-icon icon="BookIcon" />
                    <span class="align-middle ml-50">Jurnal</span>
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
                  :sort-compare="true"
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
import Ripple from 'vue-ripple-directive'
import vSelect from 'vue-select'

import {
  BFormGroup,
  BButton,
  BDropdown,
  BDropdownItem,
  BInputGroup,
  BInputGroupAppend,
  // BFormDatepicker,
  BLink,
  BBadge,
  BCardBody,
  BCardText,
  BCard,
  BRow,
  BCol,
  BFormInput,
  BTable,
  BPagination,
  BMedia,
  BAvatar,
  BMediaAside,
  BMediaBody,
} from 'bootstrap-vue'
import flatPickr from 'vue-flatpickr-component'

export default {
  components: {
    BFormGroup,
    BButton,
    BInputGroup,
    BInputGroupAppend,
    BLink,
    BDropdown,
    BDropdownItem,
    // BFormDatepicker,
    BBadge,
    BCard,
    BCardText,
    BCardBody,
    BRow,
    BCol,
    BFormInput,
    BTable,
    BPagination,
    vSelect,
    BMedia,
    BAvatar,
    BMediaAside,
    BMediaBody,
    flatPickr,
  },
  directives: {
    Ripple,
  },
  data() {
    return {
      date: {
        value: '',
        config: {
          wrap: true, // set wrap to true only when using 'input-group'
          altFormat: 'd F y',
          altInput: true,
          dateFormat: 'Y-m-d',
          mode: 'range',
        },
      },
      statusFilter: {
        label: 'Semua',
        value: 0,
      },
      dataPembayaran: {},
      filterQuery: '',
      searchQuery: '',
      refTable: null,
      listTemp: [],
      listData: [],
      listPelanggan: [],
      pelanggan: '',
    }
  },

  computed: {
    dateFilter() {
      return this.date.value
    },
    total() {
      let total = 0
      this.listData.forEach(v => {
        total += v.grand_total
      })
      return total
    },
    totalTagihan() {
      let total = 0
      this.listData.forEach(v => {
        total += v.sisa_pembayaran
      })
      return total
    },
    dataMeta() {
      const localItemsCount = this.$refs.refTable ? this.$refs.refTable.computedItems.length : 0
      return {
        from: this.perPage * (this.currentPage - 1) + (localItemsCount ? 1 : 0),
        to: this.perPage * (this.currentPage - 1) + localItemsCount,
        of: this.totalData,
      }
    },
    totalData() {
      return this.listData.length
    },
  },
  watch: {
    dateFilter(x) {
      if (x === '') {
        this.loadDataPiutang()
      } else {
        const d = x.split(' to ')
        if (d.length > 1) {
          this.loadDataPiutang(d[0], d[1])
        } else {
          this.loadDataPiutang(d[0], d[0])
        }
      }
    },
    pelanggan(x) {
      if (x === null) {
        this.loadPiutangPelanggan(null)
      } else {
        this.loadPiutangPelanggan(x.id)
      }
    },
    statusFilter(x) {
      this.loadPiutangStatus(x.value)
    },
    /* eslint-disable */
    searchQuery(query) {
      if (query === '') {
        this.listData = this.listTemp
      } else {
        this.listData = this.listTemp.filter(
          item => item.nomor_transaksi.toLowerCase().indexOf(query.toLowerCase()) > -1 || item.nama_pelanggan.toLowerCase().indexOf(query.toLowerCase()) > -1,
        )
      }
    },
    /* eslint-enable */
  },
  methods: {
    showModalPembayaran(data) {
      this.$store.commit('app-transaksi-penjualan/SET_LIST_PEMBAYARAN', data.list_pembayaran)
      this.$bvModal.show('modal-daftar-pembayaran-penjualan')
    },
    showBulkPembayaran() {
      this.$emit('bulkPembayaran', this.listPelanggan)
    },
    cekJatuhTempo(b) {
      const x = this.$moment(b.created_at)
      const y = this.$moment(b.tanggal_jatuh_tempo)
      const duration = y.diff(x, 'days')
      if (duration > 5) {
        return 'warning'
      }
      return 'danger'
    },
    loadDataPiutang(dd = null, ddd = null) {
      const dataUser = JSON.parse(localStorage.getItem('userData'))
      const cabang = dataUser.cabang_id
      store
        .dispatch('app-keuangan/getPiutang', {
          cabang,
          dd,
          ddd,
        })
        .then(res => {
          store.commit('app-keuangan/SET_DATA_PIUTANG', res.data)
          this.listTemp = res.data
          this.listData = res.data
        })
    },
    loadPiutangPelanggan(id) {
      if (id !== null) {
        this.listData = this.listTemp.filter(x => x.kontak_id === id.toString())
      } else {
        this.listData = this.listTemp
      }
    },
    loadPiutangStatus(id) {
      if (id === 1) {
        this.listData = this.listTemp.filter(x => x.sisa_pembayaran === 0)
      } else if (id === 2) {
        this.listData = this.listTemp.filter(x => x.sisa_pembayaran > 0)
      } else {
        this.listData = this.listTemp
      }
    },
    loadDataPelanggan(dd = null, ddd = null) {
      const dataUser = JSON.parse(localStorage.getItem('userData'))
      const cabang = dataUser.cabang_id
      store
        .dispatch('app-keuangan/getListPelanggan', {
          cabang,
          dd,
          ddd,
        })
        .then(res => {
          this.listPelanggan = res.data
        })
    },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
  },
  mounted() {
    this.loadDataPiutang()
    this.loadDataPelanggan()
  },
  setup() {
    const tableColumns = [
      {
        key: 'id',
      },
      {
        key: 'tanggal',
      },
      { key: 'nama_pelanggan', sortable: false },
      { key: 'nomor_transaksi', sortable: false },
      { key: 'total', sortable: false },
      { key: 'pembayaran', sortable: false },
      { key: 'sisa_saldo', sortable: false },
      {
        key: 'jatuh_tempo',
      },
      { key: 'action', sortable: false },
    ]
    // const searchQuery = ref('')
    const form = ref({
      lawan_akun_id: '',
      kode_akun_id: '',
      tanggal: new Date(),
      jenis: 1,
      jumlah: 0,
      catatan: '',
    })
    const dataUser = ref({})
    const dataAkun = ref({})
    const nomorAkun = ref([])
    const perPage = ref(10)
    const dataKas = ref([])
    const dataTemp = ref([])
    const currentPage = ref(1)
    const perPageOptions = [10, 25, 50, 100]
    const sortBy = ref('nomor_jurnal')
    const isSortDirDesc = ref(true)

    return {
      form,
      nomorAkun,
      dataAkun,
      dataUser,
      dataKas,
      dataTemp,
      tableColumns,
      perPage,
      isSortDirDesc,
      currentPage,
      perPageOptions,
      sortBy,
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
</style>
<style lang="scss">
@import '@core/scss/vue/libs/vue-flatpicker.scss';
</style>
