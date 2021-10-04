<template>
  <section ref="loading">
    <b-row>
      <b-col lg="3" cols="3" sm="12">
        <b-card>
          <b-col cols="12" md="12">
            <b-form-group label="Cabang">
              <v-select v-model="cabang" placeholder="Cabang" label="nama" :clearable="true" :options="cabangOption" @input="cabangChange()" />
            </b-form-group>
          </b-col>
          <div v-if="cabang.id === 0 ? true : false">
            <hr />
            <b-col cols="12" md="12">
              <b-form-group label="Tahun">
                <v-select v-model="tahun" placeholder="Tahunan" :clearable="true" :options="tahunOption" @input="tahunChange()" />
              </b-form-group>
            </b-col>
            <hr />
            <b-col cols="12" md="12">
              <b-form-group label="Bulan">
                <v-select v-model="bulan" placeholder="Bulanan" label="title" :clearable="true" :options="bulanOption" @input="bulanChange()" />
              </b-form-group>
            </b-col>
            <hr />
            <b-col cols="12" md="12">
              <b-form-group label="Hari">
                <b-form-datepicker
                  placeholder="Harian"
                  v-model="hari"
                  locale="id"
                  :date-format-options="{ year: 'numeric', month: 'numeric', day: 'numeric' }"
                  @input="hariChange()"
                />
              </b-form-group>
            </b-col>
          </div>
          <div v-if="cabang.id === 0 ? false : true">
            <b-col cols="12" md="12">
              <b-form-group label="Tanggal Awal">
                <b-form-datepicker
                  placeholder="Harian"
                  v-model="satuan.tanggalAwal"
                  locale="id"
                  :date-format-options="{ year: 'numeric', month: 'numeric', day: 'numeric' }"
                  @input="tanggalAwalChange()"
                />
              </b-form-group>
            </b-col>
            <b-col cols="12" md="12">
              <b-form-group label="Tanggal Akhir">
                <b-form-datepicker
                  placeholder="Harian"
                  v-model="satuan.tanggalAkhir"
                  locale="id"
                  :date-format-options="{ year: 'numeric', month: 'numeric', day: 'numeric' }"
                  @input="TanggalAkhirChange()"
                />
              </b-form-group>
            </b-col>
          </div>
          <hr />
          <b-col offset-md="3">
            <b-button variant="outline-primary" @click="generate">
              Download
            </b-button>
          </b-col>
        </b-card>
      </b-col>
      <b-col cols="9" lg="9" sm="12">
        <div v-if="cabang.id === 0 ? true : false">
          <b-card :title="title">
            <b-table responsive :fields="tableColumnSemua" :items="listDataSetoranSemua" show-empty empty-text="Tidak ada data" class="position-relative" lazy>
              <template #cell(nama_cabang)="data">
                {{ data.item.nama }}
              </template>
              <template #cell(setoran)="data">
                {{ terbuku(data.item) }}
              </template>
              <template #cell(pelaporan)="data">
                {{ formatRupiah(data.item.setoran.pelaporan.total) }}
              </template>
              <template #cell(terbuku)="data">
                {{ formatRupiah(data.item.setoran.terbuku.total) }}
              </template>
              <template #cell(sisa)="data">
                {{ sisa(data.item) }}
              </template>
              <!-- Column: Actions -->
              <template #cell(action)="data">
                <div class="text-nowrap">
                  <feather-icon icon="EyeIcon" size="16" class="mx-1" @click="showModal(data.item.setoran.pelaporan.data)" />
                </div>
              </template>
            </b-table>
          </b-card>
        </div>
        <div v-if="cabang.id === 0 ? false : true">
          <b-card :title="title">
            <b-table responsive :fields="tableColumnSatuan" :items="listDataSetoranSatuan" show-empty empty-text="Tidak ada data" class="position-relative">
              <template #cell(tanggal)="data">
                {{ $moment(data.item.tanggal).format('DD-MM-YYYY') }}
              </template>
              <template #cell(setoran)="data">
                {{ terbuku(data.item) }}
              </template>
              <template #cell(pelaporan)="data">
                {{ formatRupiah(data.item.setoran.pelaporan.total) }}
              </template>
              <template #cell(terbuku)="data">
                {{ formatRupiah(data.item.setoran.terbuku.total) }}
              </template>
              <template #cell(sisa)="data">
                {{ formatRupiah(data.item.setoran.sisa) }}
              </template>
            </b-table>
          </b-card>
        </div>
      </b-col>
    </b-row>
    <b-modal
      id="modal-prevent-closing"
      ref="modal-setoran"
      centered
      size="lg"
      title="Rincian Pelaporan Setoran"
      ok-title="Proses"
      cancel-variant="outline-secondary"
    >
      <b-table responsive :fields="tableRincianSetoran" :items="listRincianSetoran" show-empty empty-text="Tidak ada data" class="position-relative">
        <template #cell(tanggal)="data">
          {{ $moment(data.item.created_at).format('DD-MM-YYYY') }}
        </template>
        <template #cell(nominal)="data">
          {{ formatRupiah(data.item.nominal) }}
        </template>
        <!-- Column: Actions -->
        <template #cell(action)="data">
          <div class="text-nowrap">
            <b-dropdown variant="link" toggle-class="p-0" no-caret>
              <template #button-content>
                <feather-icon icon="MoreVerticalIcon" size="16" class="align-middle text-body" />
              </template>
              <b-dropdown-item @click="confirm(data.item.id, 'APPROVED')">
                <feather-icon icon="CheckCircleIcon" />
                <span class="align-middle ml-50">Approve</span>
              </b-dropdown-item>
              <b-dropdown-item @click="confirm(data.item.id, 'REJECT')">
                <feather-icon icon="XCircleIcon" />
                <span class="align-middle ml-50">Reject</span>
              </b-dropdown-item>
            </b-dropdown>
          </div>
        </template>
      </b-table>
    </b-modal>
  </section>
</template>

<script>
import { BDropdown, BDropdownItem, BModal, BRow, BCol, BCard, BTable, BFormDatepicker, BFormGroup, BButton } from 'bootstrap-vue'
import { formatRupiah } from '@core/utils/filter'
import Ripple from 'vue-ripple-directive'
import vSelect from 'vue-select'

export default {
  components: {
    BDropdown,
    BDropdownItem,
    BModal,
    BRow,
    BCol,
    BCard,
    BTable,
    BFormDatepicker,
    BFormGroup,
    BButton,
    vSelect,
  },
  data() {
    return {
      cabang: {
        nama: 'SEMUA',
        id: 0,
      },
      satuan: {
        tanggalAwal: new Date(),
        tanggalAkhir: new Date(),
      },
      title: 'Setoran SEMUA Cabang Tahun 2021',
      listDataSetoranSemua: [],
      listDataSetoranSatuan: [],
      listRincianSetoran: [],
      hari: '',
      tahun: new Date().getFullYear(),
      bulan: '',
      tahunOption: ['2021', '2022', '2023', '2024'],
      bulanOption: [
        {
          title: 'JANUARI',
          value: 1,
        },
        {
          title: 'FEBRUARI',
          value: 2,
        },
        {
          title: 'MARET',
          value: 3,
        },
        {
          title: 'APRIL',
          value: 4,
        },
        {
          title: 'MEI',
          value: 5,
        },
        {
          title: 'JUNI',
          value: 6,
        },
        {
          title: 'JULI',
          value: 7,
        },
        {
          title: 'AGUSTUS',
          value: 8,
        },
        {
          title: 'SEPTEMBER',
          value: 9,
        },
        {
          title: 'OKTOBER',
          value: 10,
        },
        {
          title: 'NOVEMBER',
          value: 11,
        },
        {
          title: 'DESEMBER',
          value: 12,
        },
      ],
      cabangOption: [{ nama: 'SEMUA', id: 0 }],
    }
  },

  directives: {
    Ripple,
  },
  mounted() {
    this.loadDataSemua()
    this.loadCabang()
  },
  methods: {
    confirm(id, confirm) {
      this.$store
        .dispatch('app-cabang/confirmSetoran', {
          id,
          confirm,
        })
        .then(res => {
          console.info(res)
        })
    },
    showModal(x) {
      this.listRincianSetoran = x
      this.$refs['modal-setoran'].show()
    },
    sisa(x) {
      const a = parseFloat(x.penjualan) + parseFloat(x.pendapatan_lainnya) - parseFloat(x.total_beban)
      const b = parseFloat(a) - parseFloat(x.setoran.terbuku.total)
      return this.formatRupiah(b)
    },
    terbuku(x) {
      const a = parseFloat(x.penjualan) + parseFloat(x.pendapatan_lainnya) - parseFloat(x.total_beban)
      return this.formatRupiah(a)
    },
    TanggalAkhirChange() {
      if (this.satuan.tanggalAwal !== null || this.satuan.tanggalAwal !== '') {
        this.loadDataSatuan()
      }
    },
    tanggalAwalChange() {
      if (this.satuan.tanggalAkhir !== null || this.satuan.tanggalAkhir !== '') {
        this.loadDataSatuan()
      }
    },
    cabangChange() {
      if (this.cabang.id === 0) {
        this.loadDataSemua()
      } else {
        this.loadDataSatuan()
      }
    },
    tahunChange() {
      this.hari = ''
      this.bulan = ''
      this.title = `Setoran Cabang ${this.cabang.nama} Tahun ${this.tahun}`
      this.loadDataSemua()
    },
    bulanChange() {
      this.hari = ''
      this.tahun = ''
      this.title = `Setoran Cabang ${this.cabang.nama} Bulan ${this.bulan.title}`
      this.loadDataSemua()
    },
    hariChange() {
      this.tahun = ''
      this.bulan = ''
      this.title = `Setoran Cabang ${this.cabang.nama} Tanggal ${this.$moment(this.hari).format('LL')}`
      this.loadDataSemua()
    },
    generate() {
      this.loadDataSemua()
    },
    formatRupiah,
    loadCabang() {
      this.$store.dispatch('app-pegawai/fetchListCabang').then(res => {
        this.cabangOption.push(...res.data)
      })
    },
    loadDataSemua() {
      const loader = this.$loading.show({
        container: this.$refs.loading,
      })
      this.$store
        .dispatch('app-cabang/fetchDataPerformanceAll', {
          tahun: this.tahun,
          bulan: this.bulan ? this.bulan.value : '',
          hari: this.hari,
        })
        .then(res => {
          loader.hide()
          this.$store.commit('app-cabang/SET_LIST_DATA_PERFORMANCE', res.data)
          this.listDataSetoranSemua = this.$store.getters['app-cabang/getListDataPerformance']
        })
    },
    loadDataSatuan() {
      this.title = `Setoran Cabang ${this.cabang.nama} dari Tanggal ${this.$moment(this.satuan.tanggalAwal).format('DD-MM-YYYY')} s/d ${this.$moment(
        this.satuan.tanggalAkhir,
      ).format('DD-MM-YYYY')}`
      const loader = this.$loading.show({
        container: this.$refs.loading,
      })
      this.$store
        .dispatch('app-cabang/fetchDataPerformanceSatuan', {
          cabang_id: this.cabang.id,
          awal: this.$moment(this.satuan.tanggalAwal).format('YYYY-M-D'),
          akhir: this.$moment(this.satuan.tanggalAkhir).format('YYYY-M-D'),
        })
        .then(res => {
          loader.hide()
          this.$store.commit('app-cabang/SET_LIST_DATA_PERFORMANCE_SATUAN', res.data)
          this.listDataSetoranSatuan = this.$store.getters['app-cabang/getListDataPerformanceSatuan']
        })
    },
  },
  setup() {
    const tableColumnSemua = [{ key: 'nama_cabang' }, { key: 'setoran' }, { key: 'pelaporan' }, { key: 'terbuku' }, { key: 'sisa' }, { key: 'action' }]
    const tableColumnSatuan = [{ key: 'tanggal' }, { key: 'setoran' }, { key: 'pelaporan' }, { key: 'terbuku' }, { key: 'sisa' }, { key: 'action' }]
    const tableRincianSetoran = [{ key: 'tanggal' }, { key: 'nominal' }, { key: 'tipe' }, { key: 'catatan' }, { key: 'status' }, { key: 'action' }]
    const userData = JSON.parse(localStorage.getItem('userData'))

    return {
      userData,
      tableRincianSetoran,
      tableColumnSemua,
      tableColumnSatuan,
    }
  },
}
</script>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
</style>
