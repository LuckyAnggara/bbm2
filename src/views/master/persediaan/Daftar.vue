<template>
  <section>
    <b-row>
      <b-col cols="12" md="9" xl="9">
        <b-card :title="gudang ? `Persediaan Gudang  ${gudang.nama}` : `Gudang belum di pilih`">
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
                  <b-form-input v-model="searchQuery" class="d-inline-block mr-1" placeholder="Cari data... (Kode Barang, Nama Barang)" />
                </div>
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
            :items="dataPersediaan"
            :fields="tableColumns"
            :current-page="currentPage"
            :per-page="perPage"
          >
            <!-- Column: Nomor -->
            <template #cell(no)="data">
              <span>
                {{ data.index + 1 }}
              </span>
            </template>

            <!-- Column: DEBIT KREDIT SALDO-->
            <template #cell(debit)="data">
              <span>
                {{ data.item.persediaan.saldo_masuk ? data.item.persediaan.saldo_masuk : '-' }}
              </span>
            </template>

            <template #cell(kredit)="data">
              <span>
                {{ data.item.persediaan.saldo_keluar ? data.item.persediaan.saldo_keluar : '-' }}
              </span>
            </template>

            <template #cell(saldo)="data">
              <span>
                {{ data.item.persediaan.saldo ? data.item.persediaan.saldo : '-' }}
              </span>
            </template>
            <template #cell(saldo_rp)="data">
              <b-link @click="showModal(data.item)" class="font-weight-bold">
                {{ data.item.persediaan.saldo_rp ? formatRupiah(data.item.persediaan.saldo_rp) : '-' }}
              </b-link>
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
                      name: 'master-persediaan-detail',
                      params: { item: data.item, gudang_id: data.item.persediaan.gudang_id },
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

      <b-col cols="12" md="3" xl="3">
        <b-card>
          <!-- Button: Download -->
          <b-form-group label="Gudang" label-for="gudang">
            <v-select v-model="gudang" :options="listGudang" label="nama" :clearable="false" />
          </b-form-group>
          <b-form-group label="alamat" label-for="gudang">
            <b-form-textarea v-model="gudang.alamat" type="text" readonly />
          </b-form-group>

          <b-form-group label="Kode Akun" label-for="gudang">
            <b-form-input :value="gudang.kode_akun" readonly />
          </b-form-group>

          <b-form-group label="Kode Akun" label-for="gudang">
            <b-form-input :value="gudang.saldo != null ? formatRupiah(gudang.saldo) : formatRupiah(0)" readonly />
          </b-form-group>
        </b-card>

        <b-card v-if="gudang">
          <!-- Button: Download -->
          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="primary" class="mb-75" block>
            Download Data
          </b-button>

          <hr />

          <!-- Button: Penyesuaian Stok -->
          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="outline-secondary" class="mb-75" block :to="{ name: 'master-persediaan-penyesuaian' }">
            Penyesuaian Stok
          </b-button>

          <!-- Button: Transafer Gudang -->
          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="outline-secondary" class="mb-75" block :to="{ name: 'master-persediaan-transfer' }">
            Transfer Gudang
          </b-button>
        </b-card>
      </b-col>
    </b-row>
    <b-modal id="modal-prevent-closing" size="lg" centered ref="my-modal" title="Rincian Persediaan" ok-title="Tutup" ok-only>
      <kartu-harga-persediaan :data-harga-persediaan="dataHargaPersediaan" />
    </b-modal>
  </section>
</template>

<script>
import { ref } from '@vue/composition-api'
import {
  BLink,
  BFormGroup,
  BButton,
  BRow,
  BCol,
  BTable,
  BPagination,
  BFormInput,
  BFormTextarea,
  // BButton,
  BModal,
  BCard,
} from 'bootstrap-vue'
import Ripple from 'vue-ripple-directive'
import store from '@/store'
import vSelect from 'vue-select'
import KartuHargaPersediaan from './component/KartuHargaPersediaan.vue'

// import axios from 'axios'

export default {
  components: {
    BModal,
    BLink,
    BFormGroup,
    BButton,
    BRow,
    BCol,
    BTable,
    BPagination,
    BFormInput,
    BFormTextarea,
    // BButton,
    BCard,
    vSelect,
    KartuHargaPersediaan,
  },
  directives: {
    Ripple,
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
      gudang: '',
      filterQuery: '',
      searchQuery: '',
      refTable: null,
      dataPersediaan: [],
      dataHargaPersediaan: [],
      listGudang: [],
    }
  },
  watch: {
    gudang(x) {
      this.loadData(x)
    },
  },
  computed: {
    totalData() {
      return this.dataPersediaan.length
    },
    dataMeta() {
      const localItemsCount = this.$refs.refTable ? this.$refs.refTable.computedItems.length : 0
      return {
        from: this.perPage * (this.currentPage - 1) + (localItemsCount ? 1 : 0),
        to: this.perPage * (this.currentPage - 1) + localItemsCount,
        of: this.totalData,
      }
    },
  },
  mounted() {
    this.loadGudang()
    // this.loadData()
  },
  methods: {
    showModal(x) {
      this.dataHargaPersediaan = x
      this.$refs['my-modal'].show()
    },
    loadGudang() {
      const user = JSON.parse(localStorage.getItem('userData'))
      const cabang = user.cabang_id
      store
        .dispatch('app-persediaan/fetchListGudang', {
          cabang,
        })
        .then(res => {
          store.commit('app-persediaan/SET_LIST_GUDANG', res.data)
          this.listGudang = store.getters['app-persediaan/getListGudang']
          this.gudang = this.listGudang.find(x => x.utama === 1)
        })
    },
    loadData(data) {
      const user = JSON.parse(localStorage.getItem('userData'))
      const cabang = user.cabang_id
      const gudang = data.id
      store
        .dispatch('app-persediaan/fetchListPersediaan', {
          cabang,
          gudang,
        })
        .then(res => {
          store.commit('app-persediaan/SET_LIST_PERSEDIAAN', res.data)
          this.dataPersediaan = store.getters['app-persediaan/getListPersediaan'].filter(
            x => x.persediaan.saldo !== 0 || x.persediaan.saldo_masuk !== 0 || x.persediaan.saldo_keluar !== 0,
          )
        })
    },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
  },
  setup() {
    const tableColumns = [
      { key: 'no', sortable: true },
      { key: 'kode_barang', sortable: true },
      { label: 'Nama Barang', key: 'nama', sortable: true },
      { label: 'debit', key: 'debit', sortable: true },
      { label: 'kredit', key: 'kredit', sortable: true },
      { label: 'saldo (qty)', key: 'saldo', sortable: true },
      { label: 'saldo (Rp.)', key: 'saldo_rp', sortable: true },
      { label: 'actions', key: 'actions', sortable: true },
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
