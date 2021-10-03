<template>
  <section>
    <b-row>
      <b-col lg="12" cols="12">
        <b-card>
          <b-row>
            <b-col lg="10">
              <b-row>
                <b-col lg="6" cols="6">
                  <b-form-group label="Kode Akun" label-cols-md="4">
                    <b-form-input readonly v-model="dataAkun.kode_akun" />
                  </b-form-group>
                </b-col>
                <b-col lg="6" cols="6">
                  <b-form-group label="Nama Akun" label-cols-md="4">
                    <b-form-input readonly v-model="dataAkun.nama" />
                  </b-form-group>
                </b-col>
              </b-row>
              <b-row>
                <b-col lg="6" cols="6">
                  <b-form-group label="Nama User" label-cols-md="4">
                    <b-form-input readonly v-model="dataUser.username" />
                  </b-form-group>
                </b-col>
                <b-col lg="6" cols="6">
                  <b-form-group label="Jabatan" label-cols-md="4">
                    <b-form-input readonly v-model="dataUser.role" />
                  </b-form-group>
                </b-col>
              </b-row>
              <b-row>
                <b-col lg="6" cols="6">
                  <b-form-group label="Tanggal Data" label-cols-md="4">
                    <b-form-datepicker
                      id="tanggalKas"
                      v-model="tanggalKas"
                      locale="id"
                      :date-format-options="{ year: 'numeric', month: 'short', day: 'numeric' }"
                    />
                  </b-form-group>
                </b-col>
                <b-col lg="6" cols="6">
                  <b-form-group label="Saldo" label-cols-md="4">
                    <b-form-input readonly v-model="saldo" />
                  </b-form-group>
                </b-col>
              </b-row>
            </b-col>
            <b-col cols="2" md="6" xl="2" sm="6">
              <b-button v-ripple.400="'rgba(186, 191, 199, 0.15)'" variant="outline-danger" class="mb-75" @click="setor()" block>
                Setor Cabang
              </b-button>
              <hr />
              <b-button v-ripple.400="'rgba(186, 191, 199, 0.15)'" variant="primary" class="mb-75" block>
                Download
              </b-button>
            </b-col>
          </b-row>
        </b-card>
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
            primary-key="id"
            :fields="tableColumns"
            :items="dataKas"
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
                  :sort-compare="true"
                  :total-rows="totalDataKas"
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

      <!-- Right Col: Card -->
    </b-row>

    <b-modal
      id="modal-prevent-closing"
      ref="my-modal"
      centered
      size="lg"
      title="SETOR KAS TUNAI"
      ok-title="Proses"
      cancel-variant="outline-secondary"
      @hidden="resetModal"
      @ok="storeModal"
    >
      <!-- <b-modal id="modal-default" ref="my-modal" ok-only ok-title="Submit" centered :title="detailBarang.nama"> -->
      <b-card-body>
        <section>
          <b-row>
            <b-col cosl="12" md="12">
              <b-form-group label="Tanggal" label-cols-md="4">
                <b-form-datepicker
                  id="tanggalKas"
                  v-model="form.tanggal"
                  locale="id"
                  :date-format-options="{ year: 'numeric', month: 'short', day: 'numeric' }"
                  disabled
                />
              </b-form-group>
            </b-col>
          </b-row>

          <b-row>
            <b-col cols="12" md="12">
              <b-form-group label="Saldo Kas" label-for="saldo_kas" label-cols-md="4">
                <b-form-input id="saldo_kas" v-model="saldo" readonly type="text" />
              </b-form-group>
            </b-col>
          </b-row>
          <hr />

          <b-row>
            <b-col cosl="12" md="12">
              <b-form-group label="Jumlah" label-for="jumlah" label-cols-md="4">
                <b-form-input id="jumlah" v-model="form.jumlah" placeholder="Jumlah" type="number" />
                <small class="text-danger">Pastikan saldo penyetoran tidak melebihi saldo tersedia</small>
              </b-form-group>
            </b-col>
          </b-row>

          <b-row>
            <b-col cols="12" md="12">
              <b-form-group label="Cara Penyetoran" label-for="cara-penyetoran" label-cols-md="4">
                <v-select placeholder="Cara Penyetoran" label="title" :options="jenisPenyetoranOption" :clearable="false" v-model="form.jenis_penyetoran" />
              </b-form-group>
            </b-col>
          </b-row>

          <section v-show="form.jenis_penyetoran.value === '1' ? true : false">
            <b-row>
              <b-col cosl="12" md="12">
                <b-form-group label="Bank" label-for="" label-cols-md="4">
                  <v-select placeholder="Nama Bank" label="title" :clearable="false" :options="bankOption" v-model="form.bank" />
                </b-form-group>
              </b-col>
            </b-row>
          </section>

          <b-row>
            <b-col cosl="12" md="12">
              <b-form-group label="Catatan" label-for="catatan" label-cols-md="4">
                <b-form-textarea id="catatan" v-model="form.catatan" placeholder="Catatan" type="text" />
              </b-form-group>
            </b-col>
          </b-row>
        </section>
      </b-card-body>
    </b-modal>
  </section>
</template>

<script>
import store from '@/store'
import { ref } from '@vue/composition-api'
import Ripple from 'vue-ripple-directive'
import vSelect from 'vue-select'

import {
  BCardBody,
  BCard,
  BFormGroup,
  BRow,
  BCol,
  BLink,
  BFormInput,
  BTable,
  BPagination,
  BFormDatepicker,
  BButton,
  BModal,
  BFormTextarea,
} from 'bootstrap-vue'

export default {
  name: 'kas',

  components: {
    BCardBody,
    BModal,
    BFormDatepicker,
    BButton,
    BCard,
    BRow,
    BCol,
    BLink,
    BFormInput,
    BTable,
    BPagination,
    BFormGroup,
    BFormTextarea,
    vSelect,
  },
  directives: {
    Ripple,
  },
  data() {
    const today = new Date()
    return {
      bankOption: [],
      filterQuery: '',
      searchQuery: '',
      refTable: null,
      tanggalKas: today,
      jenisPenyetoranOption: [
        { title: 'Tunai', value: '0' },
        { title: 'Transfer', value: '1' },
      ],
    }
  },
  computed: {
    dataMeta() {
      const localItemsCount = this.$refs.refTable ? this.$refs.refTable.computedItems.length : 0
      return {
        from: this.perPage * (this.currentPage - 1) + (localItemsCount ? 1 : 0),
        to: this.perPage * (this.currentPage - 1) + localItemsCount,
        of: this.totalDataKas,
      }
    },
    saldo() {
      return this.formatRupiah(parseFloat(this.dataAkun.saldo))
    },
    totalDataKas() {
      return this.dataKas.length
    },
  },
  watch: {
    // transfer() {
    //   if (this.transfer.value === '1') {
    //     this.loadTransfer(store.getters['app-keuangan/getListAkun'])
    //   } else {
    //     this.loadTunai(store.getters['app-keuangan/getListAkun'])
    //   }
    //   this.form.lawan_akun_id_ke = ''
    // },
    /* eslint-disable */
    searchQuery(query) {
      if (query === '') {
        this.dataKas = this.dataTemp
      } else {
        this.dataKas = this.dataTemp.filter(
          item =>
            item.nomor_jurnal.toLowerCase().indexOf(query.toLowerCase()) > -1 ||
            item.keterangan.toLowerCase().indexOf(query.toLowerCase()) > -1 ||
            item.saldo.toString().indexOf(query) > -1,
        )
      }
    },
    /* eslint-disable */
    tanggalKas(q) {
      const d = new Date()
      const y = d.getFullYear()
      this.loadKas(this.$moment(new Date(y, 0, 1)).format('Y-MM-DD'), this.$moment(q).format('Y-MM-DD'))
    },
  },
  mounted() {
    const d = new Date()
    const y = d.getFullYear()
    this.loadKas(this.$moment(new Date(y, 0, 1)).format('Y-MM-DD'), this.$moment(Date.now()).format('Y-MM-DD'))
    this.loadBank()
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
          console.info(store.getters['app-keuangan/getListSetorCabang'])
        })
    },
    storeModal() {
      if (this.form.jumlah <= 0) {
        this.$swal({
          icon: 'error',
          title: 'Oopss jumlah nominal masih kosong',
          customClass: {
            confirmButton: 'btn btn-success',
          },
        })
        return
      }
      this.form.user = this.dataUser
      this.form.cabang_id_dari = this.dataUser.cabang_id
      store.dispatch('app-keuangan/storeKasCabang', this.form).then(res => {
        if (res.status === 200) {
          this.$swal({
            icon: 'success',
            title: 'Transaksi berhasil',
            customClass: {
              confirmButton: 'btn btn-success',
            },
          })
          this.loadDataKirim()
        }
      })
    },
    resetModal() {},
    setor() {
      this.$refs['my-modal'].show()
    },
    clear() {
      this.date.value = null
      this.dateFilter(null)
    },
    dateFilter(x) {
      this.loadLedger(this.$moment(x[0]).format('Y-MM-DD'), this.$moment(x[1]).format('Y-MM-DD'))
    },
    moment(value) {
      return this.$moment(value).format('DD MMMM YYYY')
    },
    loadBank() {
      store.dispatch('app-transaksi-penjualan/fetchDataBank', this.dataOrder).then(res => {
        this.bankOption = res.data
      })
    },
    loadKas(dateawal = null, dateakhir = null) {
      store
        .dispatch('app-keuangan/fetchLedgerByAkun', {
          cabang_id: this.dataUser.cabang_id,
          id: this.dataUser.cabang.kode_akun_id,
          dateawal,
          dateakhir,
        })
        .then(res => {
          this.dataAkun = res.data
          this.dataTemp = this.dataAkun.ledger
          this.dataKas = this.dataTemp
        })
    },
    loadNomorAkun() {
      store.dispatch('app-keuangan/fetchListAkun', { tahun: '', cabang_id: this.dataUser.cabang_id }).then(res => {
        store.commit('app-keuangan/SET_LIST_AKUN', res.data)
        if (this.transfer === false) {
          this.loadTunai(store.getters['app-keuangan/getListAkun'])
        } else {
          this.loadTransfer(store.getters['app-keuangan/getListAkun'])
        }
      })
    },
    // loadTunai(data) {
    //   this.nomorAkun = []
    //   data.forEach(x => {
    //     x.subheader.forEach(y => {
    //       if (y.komponen.length !== 0) {
    //         y.komponen.forEach(a => {
    //           if (a.komponen == '1.1.2') {
    //             if (a.kode_akun !== this.dataAkun.kode_akun) {
    //               if (a.cabang_id === this.cabang.id) this.nomorAkun.push(a)
    //             }
    //           }
    //         })
    //       }
    //     })
    //   })
    //   return this.nomorAkun
    // },
    // loadTransfer(data) {
    //   this.nomorAkun = []
    //   data.forEach(x => {
    //     x.subheader.forEach(y => {
    //       if (y.komponen.length !== 0) {
    //         y.komponen.forEach(a => {
    //           if (a.komponen == '1.1.3') {
    //             if (a.kode_akun !== this.dataAkun.kode_akun) {
    //               if (a.cabang_id !== this.cabang.id) this.nomorAkun.push(a)
    //             }
    //           }
    //         })
    //       }
    //     })
    //   })
    //   return this.nomorAkun
    // },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
  },
  setup() {
    const dataUser = JSON.parse(localStorage.getItem('userData'))
    const tableColumns = [
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
    const form = ref({
      cabang_id_ke: 1,
      cabang_id_dari: dataUser.cabang_id,
      jenis_penyetoran: { title: 'Tunai', value: '0' },
      bank: null,
      tanggal: new Date(),
      jumlah: 0,
      catatan: '',
    })
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
