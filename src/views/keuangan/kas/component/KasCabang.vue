<template>
  <section>
    <b-row>
      <b-col lg="9" cols="12">
        <b-card>
          <b-row>
            <b-col lg="12" cols="12">
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
            </b-col>
            <b-col lg="12" cols="12">
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
            </b-col>
            <b-col lg="12" cols="12">
              <b-row>
                <b-col lg="6" cols="6">
                  <b-form-group label="Tanggal Data" label-cols-md="4">
                    <b-form-datepicker id="tanggalKas" v-model="tanggalKas" locale="id" />
                  </b-form-group>
                </b-col>
                <b-col lg="6" cols="6">
                  <b-form-group label="Saldo" label-cols-md="4">
                    <b-form-input readonly v-model="saldo" />
                  </b-form-group>
                </b-col>
              </b-row>
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
      <b-col cols="12" md="3" xl="3">
        <b-card>
          <!-- Button: Tarik -->
          <!-- <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="outline-primary" class="mb-75" @click="tarik()" block>
            Tarik Cabang
          </b-button> -->

          <!-- Button: SETOR -->
          <b-button v-ripple.400="'rgba(186, 191, 199, 0.15)'" variant="outline-danger" class="mb-75" @click="setor()" block>
            Setor Cabang
          </b-button>

          <hr />
          <!-- Button: Download -->
          <b-button v-ripple.400="'rgba(186, 191, 199, 0.15)'" variant="primary" class="mb-75" block>
            Download
          </b-button>
        </b-card>
      </b-col>
    </b-row>

    <b-modal
      id="modal-prevent-closing"
      ref="my-modal"
      centered
      size="lg"
      :title="titleModal"
      ok-title="Proses"
      cancel-variant="outline-secondary"
      @hidden="resetModal"
      @ok="storeModal"
    >
      <!-- <b-modal id="modal-default" ref="my-modal" ok-only ok-title="Submit" centered :title="detailBarang.nama"> -->
      <b-card-body>
        <section>
          <p>
            <b>{{ subTextModal }} {{ form.lawan_akun_id_ke.nama }}</b>
          </p>
          <b-row>
            <b-col cosl="12" md="12">
              <b-form-group label="Tanggal" label-cols-md="4">
                <b-form-datepicker id="tanggalKas" v-model="form.tanggal" locale="id" disabled />
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
                <small class="text-danger">{{ subSmallText }}</small>
              </b-form-group>
            </b-col>
          </b-row>

          <b-row>
            <b-col cosl="12" md="12">
              <b-form-group label="Ke Cabang" label-for="jumlah" label-cols-md="4">
                <v-select placeholder="Cabang" v-model="cabang" label="nama" :options="listCabang" :clearable="false" />
              </b-form-group>
            </b-col>
          </b-row>

          <section v-show="caraPembayaran">
            <b-row>
              <b-col cols="12" md="12">
                <b-form-group label="Cara Pembayaran" label-for="cara-pembayaran" label-cols-md="4">
                  <v-select placeholder="Cara Pembayaran" label="title" :options="jenisPembayaranOption" :clearable="false" v-model="transfer" />
                </b-form-group>
              </b-col>
            </b-row>
          </section>

          <b-row>
            <b-col cosl="12" md="12">
              <b-form-group :label="`${form.jenis}`" label-for="" label-cols-md="4">
                <v-select v-model="form.lawan_akun_id_ke" placeholder="Nomor Akun" label="nama" :clearable="true" :options="nomorAkun">
                  <template v-slot:option="option">
                    {{ option.kode_akun }} - <b>{{ option.nama }}</b>
                  </template>
                </v-select>
              </b-form-group>
            </b-col>
          </b-row>

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
      cabang: '',
      transfer: false,
      caraPembayaran: true,
      filterQuery: '',
      searchQuery: '',
      refTable: null,
      tanggalKas: today,
      titleModal: '',
      subTextModal: '',
      subSmallText: '',
      listCabang: [],
      jenisPembayaranOption: [
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
    transfer() {
      if (this.transfer.value === '1') {
        this.loadTransfer(store.getters['app-keuangan/getListAkun'])
      } else {
        this.loadTunai(store.getters['app-keuangan/getListAkun'])
      }
      this.form.lawan_akun_id_ke = ''
    },
    cabang() {
      this.transfer = ''
      this.nomorAkun = []
      this.form.lawan_akun_id_ke = ''
      this.loadNomorAkun()
    },
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
      this.loadUser()
      this.loadKas(this.$moment(new Date(y, 0, 1)), this.$moment(q))
    },
  },
  mounted() {
    const d = new Date()
    const y = d.getFullYear()
    this.loadUser()
    this.loadKas(this.$moment(new Date(y, 1, 1)), this.$moment(Date.now()))
    this.loadCabang()
  },
  methods: {
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
      if (this.form.lawan_akun_id_ke == '') {
        this.$swal({
          icon: 'error',
          title: 'Oopss akun tujuan belum di tentukan',
          customClass: {
            confirmButton: 'btn btn-success',
          },
        })
        return
      }
      const dataUser = JSON.parse(localStorage.getItem('userData'))
      this.form.user = dataUser
      this.form.cabang_id_ke = this.cabang
      this.form.cabang_id_dari = dataUser.cabang
      store.dispatch('app-keuangan/storeKasCabang', this.form).then(res => {
        if (res.status === 200) {
          this.$swal({
            icon: 'success',
            title: 'Transaksi berhasil',
            customClass: {
              confirmButton: 'btn btn-success',
            },
          })
          // this.loadKas(this.tanggalKas)
        }
      })
    },
    resetModal() {
      this.titleModal = ''
      this.subTextModal = ''
      this.subSmallText = ''
      this.form.jenis = 'DEBIT'
      this.form.jumlah = 0
      this.form.lawan_akun_id_ke = ''
      this.form.catatan = ''
      this.form.cabang_id_ke = ''
      this.form.cabang_id_dari = ''
      this.form.lawan_akun_id_dari = ''
      this.form.lawan_akun_id_ke = ''
    },
    tarik() {
      this.titleModal = 'TARIK KAS'
      this.subTextModal = ''
      this.subSmallText = ''
      this.form.jenis = 'DEBIT'
      this.$refs['my-modal'].show()
    },
    setor() {
      this.titleModal = 'SETOR KAS'
      this.subTextModal = ''
      this.subSmallText = 'Pastikan saldo penyetoran tidak melebihi saldo tersedia'
      this.form.jenis = 'KREDIT'
      this.$refs['my-modal'].show()
    },
    loadUser() {
      const user = JSON.parse(localStorage.getItem('userData'))
      this.dataUser = user
    },
    clear() {
      this.date.value = null
      this.dateFilter(null)
    },
    dateFilter(x) {
      this.loadLedger(this.$moment(x[0]), this.$moment(x[1]))
    },
    moment(value) {
      return this.$moment(value).format('DD MMMM YYYY')
    },
    loadCabang() {
      const dataUser = JSON.parse(localStorage.getItem('userData'))
      const cabang = dataUser.cabang_id
      store.dispatch('app-pegawai/fetchListCabang').then(res => {
        this.listCabang = res.data.filter(x => x.id !== cabang)
      })
    },
    loadKas(dateawal = null, dateakhir = null) {
      const dataUser = JSON.parse(localStorage.getItem('userData'))
      const cabang = dataUser.cabang_id
      const id = dataUser.cabang.kode_akun_id
      store
        .dispatch('app-keuangan/fetchLedgerByAkun', {
          cabang,
          id,
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
      const dataUser = JSON.parse(localStorage.getItem('userData'))
      store.dispatch('app-keuangan/fetchListAkun', { tahun: null, cabang: this.cabang.id }).then(res => {
        store.commit('app-keuangan/SET_LIST_AKUN', res.data)
        if (this.transfer === false) {
          this.loadTunai(store.getters['app-keuangan/getListAkun'])
        } else {
          this.loadTransfer(store.getters['app-keuangan/getListAkun'])
        }
      })
    },
    loadTunai(data) {
      this.nomorAkun = []
      const dataUser = JSON.parse(localStorage.getItem('userData'))
      data.forEach(x => {
        x.subheader.forEach(y => {
          if (y.komponen.length !== 0) {
            y.komponen.forEach(a => {
              if (a.komponen == '1.1.2') {
                if (a.kode_akun !== this.dataAkun.kode_akun) {
                  if (a.cabang_id === this.cabang.id) this.nomorAkun.push(a)
                }
              }
            })
          }
        })
      })
      return this.nomorAkun
    },
    loadTransfer(data) {
      this.nomorAkun = []
      const dataUser = JSON.parse(localStorage.getItem('userData'))
      data.forEach(x => {
        x.subheader.forEach(y => {
          if (y.komponen.length !== 0) {
            y.komponen.forEach(a => {
              if (a.komponen == '1.1.3') {
                if (a.kode_akun !== this.dataAkun.kode_akun) {
                  if (a.cabang_id !== this.cabang.id) this.nomorAkun.push(a)
                }
              }
            })
          }
        })
      })
      return this.nomorAkun
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
      cabang_id_ke: '',
      cabang_id_dari: '',
      lawan_akun_id_dari: '',
      lawan_akun_id_ke: '',
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
