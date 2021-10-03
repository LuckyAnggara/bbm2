<template>
  <section>
    <b-row>
      <b-col lg="12" cols="12">
        <b-card title="Daftar Kirim Setoran">
          <div class="mb-2">
            <!-- Table Top -->
            <b-row>
              <!-- Per Page -->
              <b-col cols="12" md="6" class="d-flex align-items-center justify-content-start mb-1 mb-md-0">
                <label>Entries</label>
                <v-select v-model="perPage" :options="perPageOptions" :clearable="false" class="per-page-selector d-inline-block ml-50 mr-1" />
              </b-col>
            </b-row>
          </div>

          <b-table
            ref="refTable"
            responsive
            primary-key="id"
            :fields="tableColumns"
            :items="listData"
            :current-page="currentPage"
            :per-page="perPage"
            show-empty
            :sort-by.sync="sortBy"
            :sort-desc.sync="isSortDirDesc"
            class="position-relative"
          >
            <!-- Column: Tanggal -->
            <template #cell(tanggal)="data">
              <span>
                {{ $moment(data.item.created_at).format('DD-MMM-YYYY') }}
              </span>
            </template>

            <!-- Column: Nomor Jurnal -->
            <template #cell(cabang_tujuan)="data">
              <span>{{ data.item.cabang_id_ke.nama }}</span>
            </template>

            <!-- Column: DEBIT KREDIT SALDO-->
            <template #cell(status)="data">
              <b-badge :variant="data.item.status == 'SEND' ? 'light-warning' : data.item.status == 'APPROVED' ? 'light-success' : 'light-danger'">
                <span>{{ data.item.status }}</span>
              </b-badge>
            </template>

            <template #cell(nominal)="data">
              <span>
                {{ formatRupiah(data.item.nominal) }}
              </span>
            </template>
            <!-- Column: Actions -->
            <template #cell(action)="data">
              <div class="text-nowrap">
                <b-dropdown variant="link" toggle-class="p-0" no-caret>
                  <template #button-content>
                    <feather-icon icon="MoreVerticalIcon" size="16" class="align-middle text-body" />
                  </template>
                  <b-dropdown-item @click="batal(data.item.id)" v-show="data.item.status === 'SEND'">
                    <feather-icon icon="TrashIcon" />
                    <span class="align-middle ml-50">Batalakan</span>
                  </b-dropdown-item>
                  <b-dropdown-item
                    :to="{ name: 'akuntansi-jurnal-detail', params: { id: data.item.nomor_jurnal_dari } }"
                    v-show="data.item.status === 'APPROVED'"
                  >
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
  BDropdown,
  BDropdownItem,
  BBadge,
  BCard,
  BRow,
  BCol,
  // BFormInput,
  BTable,
  BPagination,
} from 'bootstrap-vue'

export default {
  components: {
    BDropdown,
    BDropdownItem,
    BBadge,
    BCard,
    BRow,
    BCol,
    BTable,
    BPagination,
    vSelect,
  },
  directives: {
    Ripple,
  },
  data() {
    return {
      filterQuery: '',
      searchQuery: '',
      refTable: null,
    }
  },
  mounted() {
    this.loadDataKirim()
    this.listData = store.getters['app-keuangan/getListSetorCabang']
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
    saldo() {
      return this.formatRupiah(parseFloat(this.dataAkun.saldo))
    },
    totalData() {
      return this.listData.length
    },
  },
  methods: {
    loadDataKirim(dateawal = null, dateakhir = null) {
      const dataUser = JSON.parse(localStorage.getItem('userData'))
      const cabang = dataUser.cabang_id
      const jenis = 'KIRIM'
      store
        .dispatch('app-keuangan/fetchListSetorCabang', {
          jenis,
          cabang,
          dateawal,
          dateakhir,
        })
        .then(res => {
          store.commit('app-keuangan/SET_LIST_SETOR_CABANG', res.data)
          this.listData = store.getters['app-keuangan/getListSetorCabang']
        })
    },
    batal(id) {
      this.$swal({
        title: 'Batalkan Setoran ?',
        text: 'Setoran ini akan di batalkan',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Ya!',
        customClass: {
          confirmButton: 'btn btn-primary',
          cancelButton: 'btn btn-outline-danger ml-1',
        },
        buttonsStyling: false,
      }).then(result => {
        if (result.value) {
          store
            .dispatch('app-keuangan/batalSetor', {
              id,
            })
            .then(res => {
              if (res.status === 200) {
                this.$swal({
                  icon: 'success',
                  title: 'Setoran Dibatalkan!',
                  customClass: {
                    confirmButton: 'btn btn-success',
                  },
                })
                this.loadDataKirim()
              }
            })
        }
      })
    },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
  },
  setup() {
    const tableColumns = [
      {
        key: 'tanggal',
      },
      { key: 'cabang_tujuan', sortable: false },
      { label: 'nominal', key: 'nominal', sortable: false },
      { label: 'cara penyetoran', key: 'tipe', sortable: false },

      { label: 'status', key: 'status', sortable: false },
      { label: 'action', key: 'action', sortable: false },
    ]
    const listData = ref([])

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
      listData,
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
