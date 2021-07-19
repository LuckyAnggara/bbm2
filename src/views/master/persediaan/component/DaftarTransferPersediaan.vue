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
      :items="dataTransfer"
      :fields="tableColumns"
      :current-page="currentPage"
      :per-page="perPage"
      :sort-by.sync="sortBy"
      :sort-desc.sync="isSortDirDesc"
    >
      <template #cell(no)="data">
        <span>
          {{ data.index + 1 }}
        </span>
      </template>

      <template #cell(dari)="data">
        <span>
          {{ data.item.dari.nama }}
        </span>
      </template>

      <template #cell(ke)="data">
        <span>
          {{ data.item.ke.nama }}
        </span>
      </template>

      <template #cell(nominal)="data">
        <span>
          {{ formatRupiah(data.item.nominal) }}
        </span>
      </template>
      <!-- Column: tanggal -->
      <template #cell(tanggal)="data">
        <span>
          {{ moment(data.item.created_at) }}
        </span>
      </template>

      <!-- Column: Actions -->
      <template #cell(action)="data">
        <div class="text-nowrap">
          <feather-icon
            icon="EyeIcon"
            size="16"
            class="mx-1"
            @click="
              $router.push({
                name: 'master-persediaan-transfer-detail',
                params: { id: data.item.id },
              })
            "
          />
          <b-dropdown variant="link" toggle-class="p-0" no-caret>
            <template #button-content>
              <feather-icon icon="MoreVerticalIcon" size="16" class="align-middle text-body" />
            </template>
            <b-dropdown-item>
              <feather-icon icon="PrinterIcon" />
              <span class="align-middle ml-50">Print</span>
            </b-dropdown-item>
            <b-dropdown-item :to="{ name: 'akuntansi-jurnal-detail', params: { id: data.item.nomor_jurnal } }">
              <feather-icon icon="BookIcon" />
              <span class="align-middle ml-50">Jurnal</span>
            </b-dropdown-item>
            <hr />
            <b-dropdown-item @click="destroy(data.item.id)">
              <feather-icon icon="TrashIcon" />
              <span class="align-middle ml-50">Delete</span>
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
  </section>
</template>

<script>
import { BCol, BRow, BTable, BDropdown, BDropdownItem, BPagination, BFormInput } from 'bootstrap-vue'
import { ref } from '@vue/composition-api'
import Ripple from 'vue-ripple-directive'
import vSelect from 'vue-select'

export default {
  components: {
    BCol,
    BRow,
    BFormInput,
    BDropdown,
    BPagination,
    BDropdownItem,
    BTable,
    vSelect,
  },
  directives: {
    Ripple,
  },
  props: {
    dataTransfer: Array,
  },
  data() {
    return {
      refTable: null,
    }
  },
  watch: {
    searchQuery(query) {
      this.$emit('searchdata', query)
    },
  },
  methods: {
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
    moment(value) {
      return this.$moment(value).format('DD MMMM YYYY')
    },
    success() {
      this.$swal({
        title: 'Success!',
        text: 'Transaksi Sukses!!',
        icon: 'success',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
      // this.$router.push({
      //   name: 'master-persediaan-transfer',
      // })
    },
    error() {
      this.$swal({
        title: 'Error!',
        text: 'Delete data transfer tidak dapat di proses',
        icon: 'error',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
    },
    destroy(id) {
      this.$swal({
        title: 'Delete ?',
        text: 'Data akan di di delete',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Delete !!',
        customClass: {
          confirmButton: 'btn btn-primary',
          cancelButton: 'btn btn-outline-danger ml-1',
        },
        buttonsStyling: false,
      }).then(result => {
        if (result.value) {
          const loader = this.$loading.show({
            container: this.$refs.formContainer,
          })
          this.$store
            .dispatch('app-persediaan/destroyTransferPersediaan', {
              id,
            })
            .then(res => {
              if (res.status === 200) {
                this.$store.commit('app-persediaan/DELETE_LIST_DATA_TRANSFER', id)
                this.success()
              } else {
                this.error()
              }
              loader.hide()
            })
        }
      })
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
      return this.dataTransfer.length
    },
  },
  setup() {
    const tableColumns = [
      { key: 'no', sortable: false },
      { key: 'nomor_transfer', sortable: false },
      { key: 'tanggal', sortable: false },
      { key: 'dari', sortable: false },
      { key: 'ke', sortable: false },
      { key: 'nominal', sortable: false },
      { key: 'catatan', sortable: false },
      { key: 'action', sortable: false },
    ]
    const searchQuery = ref('')
    const perPage = ref(10)
    const currentPage = ref(1)
    const perPageOptions = [10, 25, 50, 100]
    const sortBy = ref('id')
    const isSortDirDesc = ref(true)

    return {
      searchQuery,
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

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
.per-page-selector {
  width: 90px;
}
</style>
