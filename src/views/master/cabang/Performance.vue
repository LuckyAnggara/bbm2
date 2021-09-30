<template>
  <section>
    <b-row>
      <b-col lg="5" cols="5" sm="12">
        <b-card>
          <b-col cols="12" md="12">
            <b-form-group label="Cabang" label-for="bank" label-cols-md="3">
              <v-select v-model="cabang" placeholder="Cabang" label="nama" :clearable="true" :options="cabangOption" @input="cabangChange()" />
            </b-form-group>
          </b-col>
          <div v-if="cabang.id === 0 ? true : false">
            <hr />
            <b-col cols="12" md="12">
              <b-form-group label="Tahun" label-for="bank" label-cols-md="3">
                <v-select v-model="tahun" placeholder="Tahunan" :clearable="true" :options="tahunOption" @input="tahunChange()" />
              </b-form-group>
            </b-col>
            <hr />
            <b-col cols="12" md="12">
              <b-form-group label="Bulan" label-for="bank" label-cols-md="3">
                <v-select v-model="bulan" placeholder="Bulanan" label="title" :clearable="true" :options="bulanOption" @input="bulanChange()" />
              </b-form-group>
            </b-col>
            <hr />
            <b-col cols="12" md="12">
              <b-form-group label="Hari" label-for="bank" label-cols-md="3">
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
              <b-form-group label="Tanggal Awal" label-for="bank" label-cols-md="3">
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
              <b-form-group label="Tanggal Akhir" label-for="bank" label-cols-md="3">
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
    </b-row>
    <b-row>
      <b-col cols="12" lg="12" sm="12" ref="loading">
        <div v-if="cabang.id === 0 ? true : false">
          <b-card :title="title">
            <b-table responsive :fields="tableColumnsAll" :items="listDataPerformanceAll" show-empty empty-text="Tidak ada data" class="position-relative">
              <template #cell(nama_cabang)="data">
                {{ data.item.nama }}
              </template>
              <template #cell(penjualan)="data">
                {{ formatRupiah(data.item.penjualan) }}
              </template>
              <template #cell(pendapatan_lainnya)="data">
                {{ formatRupiah(data.item.pendapatan_lainnya) }}
              </template>
              <template #cell(hpp)="data">
                {{ formatRupiah(data.item.hpp) }}
              </template>
              <template #cell(gross_margin)="data"> {{ data.item.gross_margin }}% </template>
              <template #cell(beban)="data">
                {{ formatRupiah(data.item.total_beban) }}
              </template>
              <template #cell(laba)="data">
                {{ formatRupiah(data.item.laba_rugi) }}
              </template>
            </b-table>
          </b-card>
        </div>
        <div v-if="cabang.id === 0 ? false : true">
          <b-card :title="title">
            <b-table
              responsive
              :fields="tableColumnsSatuan"
              :items="listDataPerformanceSatuan"
              show-empty
              empty-text="Tidak ada data"
              class="position-relative"
              foot-clone
            >
              <template #cell(tanggal)="data">
                {{ $moment(data.item.tanggal).format('DD-MM-YYYY') }}
              </template>
              <template #cell(penjualan)="data">
                <span :class="data.item.penjualan === 0 ? '' : data.item.penjualan < 0 ? 'text-danger' : 'text-success'"
                  >{{ formatRupiah(data.item.penjualan) }}
                </span>
              </template>
              <template #cell(pendapatan_lainnya)="data">
                <span :class="data.item.pendapatan_lainnya === 0 ? '' : data.item.pendapatan_lainnya < 0 ? 'text-danger' : 'text-success'"
                  >{{ formatRupiah(data.item.pendapatan_lainnya) }}
                </span>
              </template>
              <template #cell(hpp)="data">
                <span :class="data.item.hpp === 0 ? '' : data.item.hpp > 0 ? 'text-danger' : 'text-success'">{{ formatRupiah(data.item.hpp) }} </span>
              </template>
              <template #cell(gross_margin)="data">
                <span :class="data.item.gross_margin === 0 ? '' : data.item.gross_margin < 0 ? 'text-danger' : 'text-success'"
                  >{{ data.item.gross_margin }}%
                </span></template
              >
              <template #cell(beban)="data">
                <span :class="data.item.total_beban === 0 ? '' : data.item.total_beban > 0 ? 'text-danger' : 'text-success'">{{
                  formatRupiah(data.item.total_beban)
                }}</span>
              </template>
              <template #cell(laba)="data">
                <span :class="data.item.laba_rugi === 0 ? '' : data.item.laba_rugi < 0 ? 'text-danger' : 'text-success'">{{
                  formatRupiah(data.item.laba_rugi)
                }}</span>
              </template>

              <!-- FOOT -->
              <template #foot(tanggal)>
                Total
              </template>
              <template #foot(penjualan)>
                <span :class="totalPenjualan < 0 ? 'text-danger' : 'text-success'">{{ formatRupiah(totalPenjualan) }}</span>
              </template>
              <template #foot(pendapatan_lainnya)>
                <span :class="totalPendapatanLainnya < 0 ? 'text-danger' : 'text-success'">{{ formatRupiah(totalPendapatanLainnya) }}</span>
              </template>
              <template #foot(hpp)>
                <span :class="totalHpp > 0 ? 'text-danger' : 'text-success'">{{ formatRupiah(totalHpp) }}</span>
              </template>
              <template #foot(gross_margin)>
                <span :class="totalGrossMargin < 0 ? 'text-danger' : 'text-success'">{{ totalGrossMargin.toFixed(2) }}%</span>
              </template>
              <template #foot(beban)>
                <span :class="totalBeban > 0 ? 'text-danger' : 'text-success'">{{ formatRupiah(totalBeban) }}</span>
              </template>
              <template #foot(laba)>
                <span :class="totalLaba < 0 ? 'text-danger' : 'text-success'">{{ formatRupiah(totalLaba) }}</span>
              </template>
            </b-table>
          </b-card>
        </div>
      </b-col>
    </b-row>
  </section>
</template>

<script>
import { BRow, BCol, BCard, BTable, BFormDatepicker, BFormGroup, BButton } from 'bootstrap-vue'
import { formatRupiah } from '@core/utils/filter'
import Ripple from 'vue-ripple-directive'
import vSelect from 'vue-select'

export default {
  components: {
    vSelect,
    BRow,
    BCol,
    BCard,
    BTable,
    BFormDatepicker,
    BFormGroup,
    BButton,
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
      title: 'Performance SEMUA Cabang Tahun 2021',
      listDataPerformanceAll: [],
      listDataPerformanceSatuan: [],
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
  computed: {
    totalPenjualan() {
      let total = 0
      this.listDataPerformanceSatuan.forEach(x => {
        total += parseFloat(x.penjualan)
      })
      return total
    },
    totalPendapatanLainnya() {
      let total = 0
      this.listDataPerformanceSatuan.forEach(x => {
        total += parseFloat(x.pendapatan_lainnya)
      })
      return total
    },
    totalHpp() {
      let total = 0
      this.listDataPerformanceSatuan.forEach(x => {
        total += parseFloat(x.hpp)
      })
      return total
    },
    totalGrossMargin() {
      let total = 0
      this.listDataPerformanceSatuan.forEach(x => {
        total += parseFloat(x.gross_margin)
      })
      return total / this.listDataPerformanceSatuan.filter(x => x.gross_margin !== 0).length
    },
    totalBeban() {
      let total = 0
      this.listDataPerformanceSatuan.forEach(x => {
        total += parseFloat(x.total_beban)
      })
      return total
    },
    totalLaba() {
      let total = 0
      this.listDataPerformanceSatuan.forEach(x => {
        total += parseFloat(x.laba_rugi)
      })
      return total
    },
  },
  mounted() {
    this.loadDataSemua()
    this.loadCabang()
  },
  methods: {
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
      this.title = `Performance Cabang ${this.cabang.nama} Tahun ${this.tahun}`
      this.loadDataSemua()
    },
    bulanChange() {
      this.hari = ''
      this.tahun = ''
      this.title = `Performance Cabang ${this.cabang.nama} Bulan ${this.bulan.title}`
      this.loadDataSemua()
    },
    hariChange() {
      this.tahun = ''
      this.bulan = ''
      this.title = `Performance Cabang ${this.cabang.nama} Tanggal ${this.$moment(this.hari).format('LL')}`
      this.loadDataSemua()
    },
    generate() {
      this.loadDataSemua()
    },
    formatRupiah,
    loadCabang() {
      this.$store.dispatch('app-pegawai/fetchListCabang').then(res => {
        this.cabangOption.push(...res.data)
        console.info(this.cabangOption)
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
          this.listDataPerformanceAll = this.$store.getters['app-cabang/getListDataPerformance']
        })
    },
    loadDataSatuan() {
      this.title = `Performance Cabang ${this.cabang.nama} dari Tanggal ${this.$moment(this.satuan.tanggalAwal).format('DD-MM-YYYY')} s/d ${this.$moment(
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
          this.listDataPerformanceSatuan = this.$store.getters['app-cabang/getListDataPerformanceSatuan']
          console.info(res.data)
        })
    },
  },
  setup() {
    const tableColumnsAll = [
      { key: 'nama_cabang', sortable: true },
      { key: 'penjualan', sortable: true },
      { key: 'pendapatan_lainnya', sortable: true },
      { key: 'hpp', sortable: true },
      { key: 'gross_margin', sortable: true },
      { key: 'beban', sortable: true },
      { key: 'laba', sortable: true },
    ]
    const tableColumnsSatuan = [
      { key: 'tanggal', sortable: true },
      { key: 'penjualan', sortable: true },
      { key: 'pendapatan_lainnya', sortable: true },
      { key: 'hpp', sortable: true },
      { key: 'gross_margin', sortable: true },
      { key: 'beban', sortable: true },
      { key: 'laba', sortable: true },
    ]
    const userData = JSON.parse(localStorage.getItem('userData'))

    return {
      userData,
      tableColumnsAll,
      tableColumnsSatuan,
    }
  },
}
</script>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
</style>
