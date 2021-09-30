<template>
  <section>
    <b-row class="match-height">
      <b-col lg="6" cols="12">
        <b-card>
          <b-row>
            <b-col lg="6" cols="12">
              <b-form-group label="Kode Akun" label-cols-md="4">
                <b-form-input readonly v-model="dataAkun.kode_akun" />
              </b-form-group>
              <b-form-group label="Klasifikasi" label-cols-md="4">
                <b-form-input readonly v-model="dataAkun.nama_jenis" />
              </b-form-group>
            </b-col>
            <b-col lg="6" cols="12">
              <b-form-group label="Saldo Akun" label-cols-md="4">
                <b-form-input readonly v-model="saldo" />
              </b-form-group>
              <b-form-group label="Sifat Akun" label-cols-md="4">
                <b-form-input readonly v-model="dataAkun.saldo_normal" />
              </b-form-group>
            </b-col>
            <b-col lg="12" cols="12">
              <b-form-group label="Nama Akun" label-cols-md="2">
                <b-form-input readonly v-model="dataAkun.nama" />
              </b-form-group>
            </b-col>
          </b-row>
          <b-row v-if="dataAkun.komponen.length > 0 ? true : false">
            <b-col lg="12" cols="12">
              <b-form-group label="Sub Akun" label-cols-md="2">
                <v-select v-model="subKomponen" label="nama" placeholder="Pilih Sub Akun" :reduce="x => x.id" :options="dataAkun.komponen">
                  <template v-slot:option="option">
                    {{ option.kode_akun }} - <b>{{ option.nama }}</b>
                  </template>
                </v-select>
              </b-form-group>
            </b-col>
            <b-col lg="12" cols="12">
              <b-form-group label="Saldo Sub Akun" label-cols-md="2">
                <b-form-input readonly v-model="saldoSub" />
              </b-form-group>
            </b-col>
          </b-row>
        </b-card>
      </b-col>
      <b-col lg="6" cols="12">
        <b-card>
          <b-form-group>
            <h5>Filter</h5>
            <hr />
            <h6 class="mb-1">Tanggal Transaksi</h6>
            <b-input-group>
              <flat-pickr v-model="date.value" class="form-control" :config="date.config" placeholder="Filter By Tanggal" @on-close="dateFilter" />
              <b-input-group-append>
                <b-button variant="outline-primary" @click="clear">
                  Clear
                </b-button>
              </b-input-group-append>
            </b-input-group>
          </b-form-group>
        </b-card>
      </b-col>
      <b-col lg="12" cols="12">
        <b-card>
          <div class="mb-2">
            <!-- Table Top -->
            <b-row>
              <!-- Per Page -->
              <b-col cols="12" md="6" class="d-flex align-items-center justify-content-start mb-1 mb-md-0">
                <label>Entries</label>
                <v-select v-model="perPage" :options="perPageOptions" :clearable="false" class="per-page-selector d-inline-block ml-50 mr-1" />
              </b-col>
              <!-- Search -->
              <b-col cols="12" md="6">
                <div class="d-flex align-items-center justify-content-end">
                  <b-form-input v-model="searchQuery" class="d-inline-block mr-1" placeholder="Cari data... (Nomor Jurnal, Nominal, Keterangan)" />
                </div>
              </b-col>
            </b-row>
          </div>

          <b-table
            ref="refTable"
            responsive
            :fields="tableColumns"
            :items="dataLedger"
            :current-page="currentPage"
            :per-page="perPage"
            :sort-desc="true"
            sort-by="id"
            show-empty
            :empty-text="emptyText"
            class="position-relative"
          >
            <!-- Column: Tanggal -->

            <template #cell(tanggal)="data">
              <span>
                {{ moment(data.item.created_at) }}
              </span>
            </template>

            <!-- Column: Nomor Jurnal -->
            <template #cell(nomor_jurnal)="data">
              <b-link :to="{ name: 'akuntansi-jurnal-detail', params: { id: data.item.nomor_jurnal } }" class="font-weight-bold">
                {{ data.item.nomor_jurnal }}
              </b-link>
            </template>

            <!-- Column: DEBIT KREDIT SALDO-->
            <template #cell(debit)="data">
              <span>
                {{ data.item.jenis === 'DEBIT' ? formatRupiah(data.item.nominal) : '-' }}
              </span>
            </template>

            <template #cell(kredit)="data">
              <span>
                {{ data.item.jenis === 'KREDIT' ? formatRupiah(data.item.nominal) : '-' }}
              </span>
            </template>

            <template #cell(saldo)="data">
              <span>
                {{ formatRupiah(data.item.saldo) }}
              </span>
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
                  :total-rows="totalLedger"
                  :per-page="perPage"
                  sort-by.sync="id"
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

import { BCard, BFormGroup, BRow, BCol, BLink, BFormInput, BTable, BPagination, BButton, BInputGroupAppend, BInputGroup } from 'bootstrap-vue'
import vSelect from 'vue-select'
import flatPickr from 'vue-flatpickr-component'

export default {
  components: {
    vSelect,
    BButton,
    BCard,
    BRow,
    BCol,
    BLink,
    BFormInput,
    BTable,
    BPagination,
    flatPickr,
    BInputGroupAppend,
    BInputGroup,
    BFormGroup,
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
      subKomponen: '',
      dataAkun: {
        kode_akun: '',
        nama_jenis: '',
        nama: '',
        saldo: 0,
        komponen: [],
      },
      dataSubAkun: {
        saldo: 0,
      },
    }
  },
  computed: {
    dataMeta() {
      const localItemsCount = this.$refs.refTable ? this.$refs.refTable.computedItems.length : 0
      return {
        from: this.perPage * (this.currentPage - 1) + (localItemsCount ? 1 : 0),
        to: this.perPage * (this.currentPage - 1) + localItemsCount,
        of: this.totalLedger,
      }
    },
    saldo() {
      return this.formatRupiah(parseFloat(this.dataAkun.saldo))
    },
    saldoSub() {
      return this.formatRupiah(parseFloat(this.dataSubAkun.saldo))
    },
    totalLedger() {
      return this.dataLedger.length
    },
    emptyText() {
      if (this.subKomponen === '') {
        return 'Sub-Akun belum di pilih'
      }
      return 'Tidak ada data'
    },
  },
  watch: {
    /* eslint-disable */
    searchQuery(query) {
      if (query === '') {
        this.dataLedger = this.dataTemp
      } else {
        this.dataLedger = this.dataTemp.filter(
          item =>
            item.nomor_jurnal.toLowerCase().indexOf(query.toLowerCase()) > -1 ||
            item.keterangan.toLowerCase().indexOf(query.toLowerCase()) > -1 ||
            item.saldo.toString().indexOf(query) > -1,
        )
      }
    },
    subKomponen(id) {
      this.fetchSubAkun(id)
    },
    /* eslint-disable */
  },
  mounted() {
    this.loadAwal()
  },
  methods: {
    clear() {
      this.date.value = null
      this.dateFilter(null)
    },
    dateFilter(x) {
      this.loadLedger(this.$moment(x[0]).format('Y-MM-DD'), this.$moment(x[1]).format('Y-MM-DD'))
    },
    moment(value) {
      return this.$moment(value).format('DD MMMM YYYY || h:mm:ss')
    },
    fetchSubAkun(id = null) {
      if (id === null) {
        this.dataTemp = []
        this.dataLedger = this.dataTemp
        this.dataSubAkun.saldo = 0
      } else {
        this.dataSubAkun = this.dataAkun.komponen.find(x => x.id === id)
        this.dataTemp = this.dataSubAkun.ledger
        this.dataLedger = this.dataTemp
      }
    },
    loadLedger(dateawal = null, dateakhir = null) {
      store
        .dispatch('app-keuangan/fetchLedgerByAkun', {
          cabang_id: this.userData.cabang_id,
          id: 44,
          dateawal,
          dateakhir,
        })
        .then(res => {
          this.dataAkun = res.data
          if (this.dataAkun.komponen.length < 1) {
            this.dataTemp = this.dataAkun.ledger
            this.dataLedger = this.dataTemp
          }
          if (this.subKomponen !== '') {
            this.fetchSubAkun(this.subKomponen)
          }
        })
    },
    loadAwal() {
      const d = new Date()
      const m = d.getMonth()
      const y = d.getFullYear()
      this.loadLedger(this.$moment(new Date(y, 0, 1)).format('Y-MM-DD'), this.$moment(Date.now()).format('Y-MM-DD'))
    },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
  },
  setup() {
    const tableColumns = [
      {
        key: 'id',
        sortable: true,
      },
      {
        key: 'tanggal',
      },
      { key: 'nomor_jurnal', sortable: false },
      { label: 'debit', key: 'debit', sortable: false },
      { label: 'kredit', key: 'kredit', sortable: false },
      {
        label: 'saldo',
        key: 'saldo',
      },
      { label: 'keterangan', key: 'keterangan', sortable: false },
    ]

    // const searchQuery = ref('')
    const perPage = ref(10)
    const dataLedger = ref([])
    const dataTemp = ref([])
    const currentPage = ref(1)
    const perPageOptions = [10, 25, 50, 100]
    const statusFilter = ref(null)
    const userData = JSON.parse(localStorage.getItem('userData'))

    return {
      userData,
      dataLedger,
      dataTemp,
      tableColumns,
      perPage,
      currentPage,
      perPageOptions,
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
