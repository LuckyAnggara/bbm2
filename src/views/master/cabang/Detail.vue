<template>
  <section>
    <b-row v-if="dataCabang">
      <b-col lg="6" cols="6">
        <b-card title="Data Cabang">
          <b-col cols="12" md="12">
            <b-form-group label="Kode Cabang">
              <b-form-input v-model="dataCabang.kode_cabang" placeholder="Kode Cabang" readonly />
            </b-form-group>
          </b-col>
          <b-col cols="12" md="12">
            <b-form-group label="Nama Cabang">
              <b-form-input v-model="dataCabang.nama" placeholder="Nama Cabang" />
            </b-form-group>
          </b-col>
          <b-col cols="12" md="12">
            <b-form-group label="Alamat">
              <b-form-input v-model="dataCabang.alamat" placeholder="Alamat" />
            </b-form-group>
          </b-col>
          <b-col cols="12" md="12">
            <b-form-group label="Nomor Telepon">
              <b-form-input v-model="dataCabang.nomor_telepon" placeholder="Nomor Telepon" />
            </b-form-group>
          </b-col>
          <b-col cols="12" md="12">
            <b-form-group label="Nomor Akun Kas">
              <b-form-input placeholder="Nomor Akun Kas" :value="nomor_akun" readonly />
            </b-form-group>
          </b-col>
          <b-col cols="12" md="12">
            <b-form-group label="Jumlah Pegawai">
              <b-form-input placeholder="Nomor Akun Kas" :value="dataCabang.pegawai.length" readonly />
            </b-form-group>
          </b-col>
          <b-col>
            <b-button variant="outline-success" @click="update">
              Save Changes
            </b-button>
          </b-col>
        </b-card>
      </b-col>
      <b-col lg="6" cols="6">
        <b-card title="Data Pegawai">
          <b-table
            ref="refTable"
            responsive
            fixed
            :busy="isBusy"
            :fields="tableColumns"
            :items="dataPegawai"
            :current-page="currentPage"
            :per-page="perPage"
            :sort-by.sync="sortBy"
            :sort-desc.sync="isSortDirDesc"
            show-empty
            empty-text="Tidak ada pegawai"
            class="position-relative"
          >
            <template #table-busy>
              <div class="text-center text-danger my-2">
                <b-spinner class="align-middle"></b-spinner>
                <strong>Mohon tunggu...</strong>
              </div>
            </template>
            <!-- Column: Id -->
            <template #cell(id)="data">
              <span>
                {{ data.index + 1 }}
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
                  :total-rows="totalPegawai"
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
import { ref } from '@vue/composition-api'

import { BCard, BRow, BCol, BFormInput, BFormGroup, BButton, BTable, BPagination } from 'bootstrap-vue'

export default {
  components: {
    BCard,
    BRow,
    BCol,
    BFormInput,
    BFormGroup,
    BButton,
    BTable,
    BPagination,
  },
  data() {
    return {
      isBusy: false,
      searchQuery: '',
      refTable: null,
    }
  },
  watch: {
    searchQuery(query) {
      if (query === '') {
        this.dataPegawai = this.dataTemp
      } else {
        this.dataPegawai = this.dataTemp.filter(
          item => item.nama.toLowerCase().indexOf(query.toLowerCase()) > -1 || item.nama.toLowerCase().indexOf(query.toLowerCase()) > -1,
        )
      }
    },
  },
  computed: {
    nomor_akun() {
      return `${this.dataCabang.akun.kode_akun} - ${this.dataCabang.akun.nama}`
    },
    dataMeta() {
      const localItemsCount = this.$refs.refTable ? this.$refs.refTable.computedItems.length : 0
      return {
        from: this.perPage * (this.currentPage - 1) + (localItemsCount ? 1 : 0),
        to: this.perPage * (this.currentPage - 1) + localItemsCount,
        of: this.totalPegawai,
      }
    },
    totalPegawai() {
      return this.dataPegawai.length
    },
  },
  mounted() {
    this.isBusy = !this.isBusy
    const { id } = this.$router.currentRoute.params
    this.$store.dispatch('app-cabang/fetchDetailCabang', { id }).then(res => {
      this.isBusy = !this.isBusy
      this.dataCabang = res.data
      this.dataTemp = res.data.pegawai
      this.dataPegawai = this.dataTemp
    })
  },
  methods: {
    update() {
      this.$swal({
        title: 'Proses ?',
        text: 'Silahkan cek kembali Penjualan sebelum memproses',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Proses!',
        customClass: {
          confirmButton: 'btn btn-primary',
          cancelButton: 'btn btn-outline-danger ml-1',
        },
        buttonsStyling: false,
      }).then(result => {
        if (result.value) {
          const loader = this.$loading.show()
          this.$store.dispatch('app-cabang/updateCabang', this.dataCabang).then(res => {
            loader.hide()
            if (res.status === 200) {
              this.$swal({
                icon: 'success',
                title: 'Data berhasil di Update!',
                customClass: {
                  confirmButton: 'btn btn-success',
                },
              })
            }
          })
        }
      })
    },
  },
  setup() {
    const userData = JSON.parse(localStorage.getItem('userData'))
    const tableColumns = [{ key: 'id', label: 'No' }, { key: 'nama' }]
    const dataCabang = ref(null)
    const dataPegawai = ref([])
    const dataTemp = ref([])
    // const searchQuery = ref('')
    const perPage = ref(10)
    const totalCabang = ref(0)
    const currentPage = ref(1)
    const perPageOptions = [10, 25, 50, 100]
    const sortBy = ref('id')
    const isSortDirDesc = ref(true)
    const statusFilter = ref(null)

    return {
      dataPegawai,
      dataTemp,
      dataCabang,
      userData,
      tableColumns,
      // searchQuery,
      perPage,
      isSortDirDesc,
      currentPage,
      totalCabang,
      perPageOptions,
      sortBy,
      statusFilter,
    }
  },
}
</script>
