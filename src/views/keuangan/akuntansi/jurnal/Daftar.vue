<template>
  <section>
    <b-row class="match-height">
      <b-col lg="6" cols="12" md="12">
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
      <b-col lg="12" cols="12" md="12">
        <b-card>
          <div class="mb-2">
            <!-- Table Top -->
            <b-row>
              <!-- Per Page -->
              <b-col cols="12" md="6" class="d-flex align-items-center justify-content-start mb-1 mb-md-0">
                <label>Entries</label>
                <v-select v-model="perPage" :options="perPageOptions" :clearable="false" class="per-page-selector d-inline-block ml-50 mr-1" />
                <b-button variant="primary" :to="{ name: 'akuntansi-jurnal-tambah' }">
                  Tambah Data
                </b-button>
              </b-col>
              <!-- Search -->
              <b-col cols="12" md="6">
                <div class="d-flex align-items-center justify-content-end">
                  <b-form-input v-model="searchQuery" class="d-inline-block mr-1" placeholder="Cari data... (Nomor Jurnal, Keterangan)" />
                </div>
              </b-col>
            </b-row>
          </div>

          <b-table
            ref="refTable"
            responsive
            primary-key="id"
            :fields="tableColumns"
            :items="dataJurnal"
            :current-page="currentPage"
            :per-page="perPage"
            :sort-by.sync="sortBy"
            :sort-desc.sync="isSortDirDesc"
            show-empty
            empty-text="Tidak ada data"
            class="position-relative"
            foot-clone
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

            <!-- Column: Nama Akun -->
            <template #cell(nama)="data">
              <b-link :to="{ name: 'akuntansi-ledger-detail', params: { id: data.item.master_akun_id } }" class="font-weight-bold">
                {{ data.item.kode_akun + ' - ' + data.item.nama_akun }}
              </b-link>
            </template>

            <!-- Column: DEBIT KREDIT -->
            <template #cell(debit)="data">
              <span class="text-nowrap">
                {{ data.item.jenis === 'DEBIT' ? formatRupiah(data.item.nominal) : '-' }}
              </span>
            </template>

            <template #cell(kredit)="data">
              <span class="text-nowrap">
                {{ data.item.jenis === 'KREDIT' ? formatRupiah(data.item.nominal) : '-' }}
              </span>
            </template>

            <!-- FOOTER -->

            <!-- Column: Actions -->
            <template #cell(actions)="data">
              <div class="text-nowrap">
                <feather-icon
                  icon="EyeIcon"
                  size="16"
                  class="mx-1"
                  @click="
                    $router.push({
                      name: 'akuntansi-jurnal-detail',
                      params: { id: data.item.nomor_jurnal },
                    })
                  "
                />
              </div>
            </template>

            <!-- Debit -->
            <template #foot(namaAkun)>
              <span>Total</span>
            </template>
            <template #foot(debit)>
              <span class="text-success">{{ formatRupiah(totalDebit) }}</span>
            </template>
            <template #foot(kredit)>
              <span class="text-danger">{{ formatRupiah(totalKredit) }}</span>
            </template>
            <template #foot(keterangan)>
              <span class="text-primary">{{ balance }}</span>
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
                  :total-rows="totalJurnal"
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

import { BLink, BCard, BFormGroup, BRow, BCol, BFormInput, BTable, BPagination, BButton, BInputGroupAppend, BInputGroup } from 'bootstrap-vue'
import vSelect from 'vue-select'
import flatPickr from 'vue-flatpickr-component'

export default {
  components: {
    BLink,
    vSelect,
    BButton,
    BCard,
    BRow,
    BCol,
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
      dataJurnal: [],
      dataTemp: [],
    }
  },
  computed: {
    dataMeta() {
      const localItemsCount = this.$refs.refTable ? this.$refs.refTable.computedItems.length : 0
      return {
        from: this.perPage * (this.currentPage - 1) + (localItemsCount ? 1 : 0),
        to: this.perPage * (this.currentPage - 1) + localItemsCount,
        of: this.totalJurnal,
      }
    },
    totalDebit() {
      let saldoDebit = 0
      this.dataJurnal.forEach(x => {
        if (x.jenis === 'DEBIT') {
          saldoDebit += parseFloat(x.nominal)
        }
      })
      return saldoDebit
    },
    totalKredit() {
      let saldoKredit = 0
      this.dataJurnal.forEach(x => {
        if (x.jenis === 'KREDIT') {
          saldoKredit += parseFloat(x.nominal)
        }
      })
      return saldoKredit
    },
    balance() {
      if (this.totalKredit === this.totalDebit) {
        return 'BALANCE'
      }
      return 'TIDAK BALANCE'
    },
  },
  watch: {
    /* eslint-disable */
    searchQuery(query) {
      if (query === '') {
        this.dataJurnal = this.dataTemp
      } else {
        this.dataJurnal = this.dataTemp.filter(
          item => item.nomor_jurnal.toLowerCase().indexOf(query.toLowerCase()) > -1 || item.keterangan.toLowerCase().indexOf(query.toLowerCase()) > -1,
        )
      }
      this.totalJurnal = this.dataJurnal.length
    },
    /* eslint-disable */
  },
  mounted() {
    const d = new Date()
    const m = d.getMonth()
    const y = d.getFullYear()
    this.loadJurnal(this.$moment(new Date(y, m, 1)), this.moment(Date.now()))
  },
  methods: {
    clear() {
      this.date.value = null
      this.dateFilter(null)
    },
    detail(x) {},
    dateFilter(x) {
      this.loadJurnal(this.moment(x[0]), this.moment(x[1]))
      this.totalJurnal = this.dataJurnal.length
    },
    moment(value) {
      return this.$moment(value).format('DD MMMM YYYY')
    },
    loadJurnal(dateawal = null, dateakhir = null) {
      const user = JSON.parse(localStorage.getItem('userData'))
      const cabang = user.cabang_id
      store
        .dispatch('app-keuangan/fetchListJurnal', {
          cabang,
          dateawal,
          dateakhir,
        })
        .then(res => {
          store.commit('app-keuangan/SET_LIST_JURNAL', res.data)
          this.dataJurnal = store.getters['app-keuangan/getListJurnal']
          this.dataTemp = store.getters['app-keuangan/getListJurnal']
          this.totalJurnal = this.dataJurnal.length
        })
    },
    formatRupiah(value) {
      return `Rp. ${value.toFixed(0).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
  },

  setup() {
    const filterOptions = ['Lunas', 'COD', 'Kredit']
    const tableColumns = [
      { key: 'tanggal', sortable: true },
      { key: 'nomor_jurnal', sortable: true },
      { label: 'nama akun', key: 'nama', sortable: true },
      { label: 'debit', key: 'debit', sortable: true },
      { label: 'kredit', key: 'kredit', sortable: true },
      { label: 'keterangan', key: 'keterangan', sortable: true },
      { label: 'actions', key: 'actions', sortable: true },
    ]

    // const searchQuery = ref('')
    const perPage = ref(10)
    const totalJurnal = ref(0)
    const currentPage = ref(1)
    const perPageOptions = [10, 25, 50, 100]
    const sortBy = ref('id')
    const isSortDirDesc = ref(true)
    const statusFilter = ref(null)

    return {
      filterOptions,
      tableColumns,
      // searchQuery,
      perPage,
      isSortDirDesc,
      currentPage,
      totalJurnal,
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

.keuangan-filter-select {
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
@import '@core/scss/vue/libs/vue-flatpicker.scss';
</style>
