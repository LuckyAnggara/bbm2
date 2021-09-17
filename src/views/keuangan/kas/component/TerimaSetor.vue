<template>
  <section>
    <b-row>
      <b-col lg="12" cols="12">
        <b-card title="Daftar Terima Setoran">
          <div class="mb-2">
            <!-- Table Top -->
            <b-row>
              <!-- Per Page -->
              <b-col cols="12" md="6" class="d-flex align-items-center justify-content-start mb-1 mb-md-0">
                <label>Entries</label>
                <v-select v-model="perPage" :options="perPageOptions" :clearable="false" class="per-page-selector d-inline-block ml-50 mr-1" />
              </b-col>
              <!-- Search -->
              <!-- <b-col cols="12" md="6">
                <div class="d-flex align-items-center justify-content-end">
                  <b-form-input v-model="searchQuery" class="d-inline-block mr-1" placeholder="Cari data... (Nomor Jurnal, Nominal, Keterangan)" />
                </div>
              </b-col> -->
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
                {{ $moment(data.item.created_at).format('Y-MMM-DD') }}
              </span>
            </template>

            <!-- Column: Nomor Jurnal -->
            <template #cell(cabang_dari)="data">
              <span>{{ data.item.cabang_id_dari.nama }}</span>
            </template>

            <!-- Column: DEBIT KREDIT SALDO-->
            <template #cell(nomor_akun)="data">
              <span>{{ data.item.kode_akun_id_ke.kode_akun }} - {{ data.item.kode_akun_id_ke.nama }}</span>
            </template>

            <!-- Column: DEBIT KREDIT SALDO-->
            <template #cell(status)="data">
              <b-badge
                :variant="data.item.status_terima == 'WAITING' ? 'light-warning' : data.item.status_terima == 'APPROVED' ? 'light-success' : 'light-danger'"
              >
                <span>{{ data.item.status_terima }}</span>
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
                  <b-dropdown-item @click="approved(data.item)" v-show="data.item.status_terima === 'WAITING'">
                    <feather-icon icon="CheckIcon" />
                    <span class="align-middle ml-50">Approved</span>
                  </b-dropdown-item>
                  <b-dropdown-item @click="reject(data.item)" v-show="data.item.status_terima === 'WAITING'">
                    <feather-icon icon="XIcon" />
                    <span class="align-middle ml-50">Rejected</span>
                  </b-dropdown-item>
                  <b-dropdown-item
                    :to="{ name: 'akuntansi-jurnal-detail', params: { id: data.item.nomor_jurnal_ke } }"
                    v-show="data.item.status_terima !== 'WAITING'"
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

import { BBadge, BCard, BRow, BCol, BDropdown, BDropdownItem, BTable, BPagination } from 'bootstrap-vue'

export default {
  components: {
    BBadge,
    BCard,
    BRow,
    BCol,
    BDropdown,
    BDropdownItem,
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
      listData: [],
    }
  },
  mounted() {
    this.loadData()
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
      return this.listData.length
    },
  },
  methods: {
    approved(data) {
      this.$swal({
        title: 'Approved Setoran ?',
        text: 'Pastikan setoran sudah di terima, dan sesuai',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Approved',
        customClass: {
          confirmButton: 'btn btn-primary',
          cancelButton: 'btn btn-outline-danger ml-1',
        },
        buttonsStyling: false,
      }).then(result => {
        if (result.value) {
          const form = data
          form.confirm = 'APPROVED'
          form.user_terima = JSON.parse(localStorage.getItem('userData'))
          store.dispatch('app-keuangan/kasCabangConfirm', data).then(res => {
            if (res.status === 200) {
              this.$swal({
                icon: 'success',
                title: 'Setoran telah di Approved',
                customClass: {
                  confirmButton: 'btn btn-success',
                },
              })
              this.loadData()
            }
          })
        }
      })
    },
    reject(data) {
      this.$swal({
        title: 'Reject Setoran ?',
        text: 'Setoran ini akan di Reject',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Reject',
        customClass: {
          confirmButton: 'btn btn-danger',
          cancelButton: 'btn btn-outline-danger ml-1',
        },
        buttonsStyling: false,
      }).then(result => {
        if (result.value) {
          const form = data
          form.confirm = 'REJECT'
          form.user_terima = JSON.parse(localStorage.getItem('userData'))
          store.dispatch('app-keuangan/kasCabangConfirm', data).then(res => {
            if (res.status === 200) {
              this.$swal({
                icon: 'success',
                title: 'Setoran telah di Reject',
                customClass: {
                  confirmButton: 'btn btn-success',
                },
              })
            }
            this.loadData()
          })
        }
      })
    },
    loadData(dateawal = null, dateakhir = null) {
      const dataUser = JSON.parse(localStorage.getItem('userData'))
      const cabang = dataUser.cabang_id
      const jenis = 'TERIMA'
      store
        .dispatch('app-keuangan/fetchListSetorCabang', {
          jenis,
          cabang,
          dateawal,
          dateakhir,
        })
        .then(res => {
          this.listData = res.data
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
      { key: 'cabang_dari', sortable: false },
      { key: 'nomor_akun', sortable: false },
      { label: 'nominal', key: 'nominal', sortable: false },

      { label: 'status', key: 'status', sortable: false },
      { label: 'action', key: 'action', sortable: false },
    ]

    const form = ref({
      lawan_akun_id: '',
      kode_akun_id: '',
      tanggal: new Date(),
      jenis: 1,
      jumlah: 0,
      catatan: '',
    })
    const perPage = ref(10)
    const currentPage = ref(1)
    const perPageOptions = [10, 25, 50, 100]
    const sortBy = ref('tanggal')
    const isSortDirDesc = ref(true)

    return {
      form,
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
