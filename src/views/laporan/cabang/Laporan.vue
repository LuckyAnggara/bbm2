<template>
  <section>
    <b-row>
      <b-col lg="3" cols="3" sm="12">
        <b-card>
          <b-col cols="12" md="12">
            <b-form-group label="Tahun">
              <v-select v-model="tahun" placeholder="Tahunan" :clearable="false" :options="tahunOption" @input="tahunChange()" />
            </b-form-group>
          </b-col>
          <hr />
          <b-col cols="12" md="12">
            <b-form-group label="Bulan">
              <v-select v-model="bulan" placeholder="Bulanan" label="title" :clearable="false" :options="bulanOption" @input="bulanChange()" />
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

          <b-col class="mt-1">
            <b-button variant="primary" @click="print">
              Print
            </b-button>
          </b-col>
        </b-card>
      </b-col>
      <b-col md="9" lg="9">
        <b-card :title="`LAPORAN CABANG ${userData.cabang.nama}`" :sub-title="tanggal.toUpperCase()">
          <hr />
          <b-form-group class="mb-2 p-0 mt-0" label="Data Penjualan">
            <b-table :busy="isBusy" small :fields="tablePenjualan" :items="transaksiPenjualan" responsive empty-text="Tidak ada data">
              <template #table-busy>
                <div class="text-center text-danger my-2">
                  <b-spinner class="align-middle"></b-spinner>
                  <strong>Mohon tunggu...</strong>
                </div>
              </template>
              <template #cell(id)="data">
                {{ data.index + 1 }}
              </template>
              <template #cell(tanggal)="data">
                {{ $moment(data.item.created_at).format('DD-MM-YYYY') }}
              </template>
              <template #cell(nama_pelanggan)="data">
                {{ data.item.kontak.nama }}
              </template>
              <template #cell(total_penjualan)="data">
                {{ formatRupiah(data.item.grand_total) }}
              </template>
              <template #cell(saldo)="data">
                <div class="text-nowrap">
                  <template v-if="data.item.sisa_pembayaran === null || data.item.sisa_pembayaran === 0">
                    <b-badge pill variant="light-success">
                      Lunas
                    </b-badge>
                  </template>
                  <template v-else>
                    <b-badge pill variant="light-danger">
                      <span class="text-danger" :id="`transaksi-row-${data.item.id}-tooltip-saldo`">-{{ formatRupiah(data.item.sisa_pembayaran) }}</span>
                    </b-badge>
                  </template>
                </div>
              </template>
            </b-table>
          </b-form-group>
          <b-form-group class="mb-2 p-0 mt-0" label="Data Beban Operasional">
            <b-table :busy="isBusy" small :fields="tableBebanOperasional" :items="daftarBebanOperasional" responsive empty-text="Tidak ada data">
              <template #table-busy>
                <div class="text-center text-danger my-2">
                  <b-spinner class="align-middle"></b-spinner>
                  <strong>Mohon tunggu...</strong>
                </div>
              </template>
              <template #cell(id)="data">
                {{ data.index + 1 }}
              </template>
              <template #cell(tanggal)="data">
                {{ $moment(data.item.created_at).format('DD-MM-YYYY') }}
              </template>
              <template #cell(nominal)="data">
                {{ formatRupiah(data.item.nominal) }}
              </template>
            </b-table>
          </b-form-group>
          <b-form-group class="mb-2 p-0 mt-0" label="Data Beban Gaji">
            <b-table :busy="isBusy" small :fields="tableBebanGaji" :items="daftarBebanGaji" responsive empty-text="Tidak ada data">
              <template #table-busy>
                <div class="text-center text-danger my-2">
                  <b-spinner class="align-middle"></b-spinner>
                  <strong>Mohon tunggu...</strong>
                </div>
              </template>
              <template #cell(id)="data">
                {{ data.index + 1 }}
              </template>
              <template #cell(tanggal)="data">
                {{ $moment(data.item.created_at).format('DD-MM-YYYY') }}
              </template>
              <template #cell(nama_pegawai)="data">
                {{ data.item.pegawai.nama }}
              </template>
              <template #cell(gaji_pokok)="data">
                {{ formatRupiah(data.item.gaji_pokok) }}
              </template>
              <template #cell(uang_makan)="data">
                {{ formatRupiah(data.item.uang_makan) }}
              </template>
              <template #cell(bonus)="data">
                {{ formatRupiah(data.item.bonus) }}
              </template>
              <template #cell(total_terima)="data">
                {{ formatRupiah(total_terima(data.item)) }}
              </template>
            </b-table>
          </b-form-group>
          <b-form-group class="mb-2 p-0 mt-0" label="Data Persediaan">
            <b-table :busy="isBusy" small :fields="tableDataPersediaan" :items="daftarPersediaan" responsive empty-text="Tidak ada data">
              <template #table-busy>
                <div class="text-center text-danger my-2">
                  <b-spinner class="align-middle"></b-spinner>
                  <strong>Mohon tunggu...</strong>
                </div>
              </template>
              <template #cell(id)="data">
                {{ data.index + 1 }}
              </template>

              <template #cell(nama)="data">
                {{ data.item.nama }}
              </template>

              <template #cell(alamat)="data">
                {{ data.item.alamat }}
              </template>

              <template #cell(saldo)="data">
                {{ formatRupiah(data.item.saldo) }}
              </template>
            </b-table>
          </b-form-group>
          <b-form-group class="mb-2 p-0 mt-0" label="Data Laporan Setoran">
            <b-table :busy="isBusy" small :fields="tableLaporanSetoran" :items="daftarLaporanSetoran" responsive empty-text="Tidak ada data">
              <template #table-busy>
                <div class="text-center text-danger my-2">
                  <b-spinner class="align-middle"></b-spinner>
                  <strong>Mohon tunggu...</strong>
                </div>
              </template>
              <template #cell(id)="data">
                {{ data.index + 1 }}
              </template>
              <template #cell(tanggal)="data">
                {{ $moment(data.item.created_at).format('DD-MM-YYYY') }}
              </template>

              <template #cell(nominal)="data">
                {{ formatRupiah(data.item.nominal) }}
              </template>
              <template #cell(saldo)="data">
                <div class="text-nowrap">
                  <b-badge pill variant="light-success" v-if="data.item.status === 'APPROVED'">
                    {{ data.item.status }}
                  </b-badge>
                  <b-badge pill variant="light-danger" v-if="data.item.status === 'REJECTED'">
                    {{ data.item.status }}
                  </b-badge>
                  <b-badge pill variant="light-warning" v-if="data.item.status === 'SEND'">
                    {{ data.item.status }}
                  </b-badge>
                </div>
              </template>
            </b-table>
          </b-form-group>
          <b-card-text>
            <b-row cols="1">
              <b-col>
                <b-form-group class="mb-0 p-0 mt-0" label="Total Penjualan" label-cols-md="3">
                  <b-form-input :value="formatRupiah(totalPenjualan)" plaintext />
                </b-form-group>
                <b-form-group class="mb-0 p-0 mt-0" label="Harga Pokok Penjualan" label-cols-md="3">
                  <b-form-input class="text-danger" :value="`(${formatRupiah(hpp)})`" plaintext />
                </b-form-group>
                <b-form-group class="mb-0 p-0 mt-0" label="Laba Kotor" label-cols-md="3">
                  <b-form-input class="font-weight-bolder" :value="formatRupiah(labaKotor)" plaintext />
                </b-form-group>
                <b-form-group class="mb-0 p-0 mt-0" label="Beban Operasional" label-cols-md="3">
                  <b-form-input class="text-danger" :value="`(${formatRupiah(bebanOperasional)})`" plaintext />
                </b-form-group>
                <b-form-group class="mb-0 p-0 mt-0" label="Beban Gaji" label-cols-md="3">
                  <b-form-input class="text-danger" :value="`(${formatRupiah(bebanGaji)})`" plaintext />
                </b-form-group>
                <b-form-group class="mb-0 p-0 mt-0" label="Laba Bersih" label-cols-md="3">
                  <b-form-input :class="labaBersih > 0 ? 'font-weight-bolder' : 'text-danger font-weight-bolder'" :value="formatRupiah(labaBersih)" plaintext />
                </b-form-group>
                <hr />
              </b-col>
              <b-col>
                <b-form-group class="mb-0 p-0 mt-0" label="Setoran" label-cols-md="3">
                  <b-form-input :value="formatRupiah(setoran)" plaintext />
                </b-form-group>
                <b-form-group class="mb-0 p-0 mt-0" label="Sudah Di Setorkan" label-cols-md="3">
                  <b-form-input :value="formatRupiah(sudahDiSetor)" plaintext />
                </b-form-group>
              </b-col>
            </b-row>
          </b-card-text>
        </b-card>
      </b-col>
      <vue-html2pdf
        :show-layout="false"
        :enable-download="true"
        :preview-modal="true"
        :filename="`LAPORAN CABANG ${userData.cabang.nama}`"
        :paginate-elements-by-height="1100"
        :pdf-quality="2"
        pdf-format="a4"
        pdf-orientation="portrait"
        pdf-content-width="800px"
        :manual-pagination="false"
        ref="html2Pdf"
      >
        <section slot="pdf-content">
          <b-card :title="`LAPORAN CABANG ${userData.cabang.nama}`" :sub-title="tanggal.toUpperCase()">
            <hr />
            <b-form-group class="mb-2 p-0 mt-0" label="Data Penjualan">
              <b-table :busy="isBusy" small :fields="tablePenjualan" :items="transaksiPenjualan" responsive empty-text="Tidak ada data">
                <template #table-busy>
                  <div class="text-center text-danger my-2">
                    <b-spinner class="align-middle"></b-spinner>
                    <strong>Mohon tunggu...</strong>
                  </div>
                </template>
                <template #cell(id)="data">
                  {{ data.index + 1 }}
                </template>
                <template #cell(tanggal)="data">
                  {{ $moment(data.item.created_at).format('DD-MM-YYYY') }}
                </template>
                <template #cell(nama_pelanggan)="data">
                  {{ data.item.kontak.nama }}
                </template>
                <template #cell(total_penjualan)="data">
                  {{ formatRupiah(data.item.grand_total) }}
                </template>
                <template #cell(saldo)="data">
                  <div class="text-nowrap">
                    <template v-if="data.item.sisa_pembayaran === null || data.item.sisa_pembayaran === 0">
                      <b-badge pill variant="light-success">
                        Lunas
                      </b-badge>
                    </template>
                    <template v-else>
                      <b-badge pill variant="light-danger">
                        <span class="text-danger" :id="`transaksi-row-${data.item.id}-tooltip-saldo`">-{{ formatRupiah(data.item.sisa_pembayaran) }}</span>
                      </b-badge>
                    </template>
                  </div>
                </template>
              </b-table>
            </b-form-group>
            <b-form-group class="mb-2 p-0 mt-0" label="Data Beban Operasional">
              <b-table :busy="isBusy" small :fields="tableBebanOperasional" :items="daftarBebanOperasional" responsive empty-text="Tidak ada data">
                <template #table-busy>
                  <div class="text-center text-danger my-2">
                    <b-spinner class="align-middle"></b-spinner>
                    <strong>Mohon tunggu...</strong>
                  </div>
                </template>
                <template #cell(id)="data">
                  {{ data.index + 1 }}
                </template>
                <template #cell(tanggal)="data">
                  {{ $moment(data.item.created_at).format('DD-MM-YYYY') }}
                </template>
                <template #cell(nominal)="data">
                  {{ formatRupiah(data.item.nominal) }}
                </template>
              </b-table>
            </b-form-group>
            <b-form-group class="mb-2 p-0 mt-0" label="Data Beban Gaji">
              <b-table :busy="isBusy" small :fields="tableBebanGaji" :items="daftarBebanGaji" responsive empty-text="Tidak ada data">
                <template #table-busy>
                  <div class="text-center text-danger my-2">
                    <b-spinner class="align-middle"></b-spinner>
                    <strong>Mohon tunggu...</strong>
                  </div>
                </template>
                <template #cell(id)="data">
                  {{ data.index + 1 }}
                </template>
                <template #cell(tanggal)="data">
                  {{ $moment(data.item.created_at).format('DD-MM-YYYY') }}
                </template>
                <template #cell(nama_pegawai)="data">
                  {{ data.item.pegawai.nama }}
                </template>
                <template #cell(gaji_pokok)="data">
                  {{ formatRupiah(data.item.gaji_pokok) }}
                </template>
                <template #cell(uang_makan)="data">
                  {{ formatRupiah(data.item.uang_makan) }}
                </template>
                <template #cell(bonus)="data">
                  {{ formatRupiah(data.item.bonus) }}
                </template>
                <template #cell(total_terima)="data">
                  {{ formatRupiah(total_terima(data.item)) }}
                </template>
              </b-table>
            </b-form-group>
            <b-form-group class="mb-2 p-0 mt-0" label="Data Laporan Setoran">
              <b-table :busy="isBusy" small :fields="tableLaporanSetoran" :items="daftarLaporanSetoran" responsive empty-text="Tidak ada data">
                <template #table-busy>
                  <div class="text-center text-danger my-2">
                    <b-spinner class="align-middle"></b-spinner>
                    <strong>Mohon tunggu...</strong>
                  </div>
                </template>
                <template #cell(id)="data">
                  {{ data.index + 1 }}
                </template>
                <template #cell(tanggal)="data">
                  {{ $moment(data.item.created_at).format('DD-MM-YYYY') }}
                </template>

                <template #cell(nominal)="data">
                  {{ formatRupiah(data.item.nominal) }}
                </template>
                <template #cell(saldo)="data">
                  <div class="text-nowrap">
                    <b-badge pill variant="light-success" v-if="data.item.status === 'APPROVED'">
                      {{ data.item.status }}
                    </b-badge>
                    <b-badge pill variant="light-danger" v-if="data.item.status === 'REJECTED'">
                      {{ data.item.status }}
                    </b-badge>
                    <b-badge pill variant="light-warning" v-if="data.item.status === 'SEND'">
                      {{ data.item.status }}
                    </b-badge>
                  </div>
                </template>
              </b-table>
            </b-form-group>
            <b-card-text>
              <b-row cols="1">
                <b-col>
                  <b-form-group class="mb-0 p-0 mt-0" label="Total Penjualan" label-cols-md="3">
                    <b-form-input :value="formatRupiah(totalPenjualan)" plaintext />
                  </b-form-group>
                  <b-form-group class="mb-0 p-0 mt-0" label="Harga Pokok Penjualan" label-cols-md="3">
                    <b-form-input class="text-danger" :value="`(${formatRupiah(hpp)})`" plaintext />
                  </b-form-group>
                  <b-form-group class="mb-0 p-0 mt-0" label="Laba Kotor" label-cols-md="3">
                    <b-form-input class="font-weight-bolder" :value="formatRupiah(labaKotor)" plaintext />
                  </b-form-group>
                  <b-form-group class="mb-0 p-0 mt-0" label="Beban Operasional" label-cols-md="3">
                    <b-form-input class="text-danger" :value="`(${formatRupiah(bebanOperasional)})`" plaintext />
                  </b-form-group>
                  <b-form-group class="mb-0 p-0 mt-0" label="Beban Gaji" label-cols-md="3">
                    <b-form-input class="text-danger" :value="`(${formatRupiah(bebanGaji)})`" plaintext />
                  </b-form-group>
                  <b-form-group class="mb-0 p-0 mt-0" label="Laba Bersih" label-cols-md="3">
                    <b-form-input
                      :class="labaBersih > 0 ? 'font-weight-bolder' : 'text-danger font-weight-bolder'"
                      :value="formatRupiah(labaBersih)"
                      plaintext
                    />
                  </b-form-group>
                  <hr />
                </b-col>
                <b-col>
                  <b-form-group class="mb-0 p-0 mt-0" label="Setoran" label-cols-md="3">
                    <b-form-input :value="formatRupiah(setoran)" plaintext />
                  </b-form-group>
                  <b-form-group class="mb-0 p-0 mt-0" label="Sudah Di Setorkan" label-cols-md="3">
                    <b-form-input :value="formatRupiah(sudahDiSetor)" plaintext />
                  </b-form-group>
                </b-col>
              </b-row>
            </b-card-text>
          </b-card>
        </section>
      </vue-html2pdf>
    </b-row>
  </section>
</template>

<script>
import { ref } from '@vue/composition-api'
import { BBadge, BSpinner, BRow, BCol, BCard, BCardText, BFormDatepicker, BButton, BFormGroup, BFormInput, BTable } from 'bootstrap-vue'
import { formatRupiah } from '@core/utils/filter'
import Ripple from 'vue-ripple-directive'
import vSelect from 'vue-select'
import VueHtml2pdf from 'vue-html2pdf'

export default {
  components: {
    vSelect,
    BBadge,
    BSpinner,
    BRow,
    BCol,
    BCard,
    BCardText,
    BFormDatepicker,
    BButton,
    BFormGroup,
    BFormInput,
    BTable,
    VueHtml2pdf,
  },
  data() {
    return {
      isBusy: false,
      tanggal: this.$moment(Date()).format('LL'),
      hari: new Date(),
      tahun: '',
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
    }
  },
  directives: {
    Ripple,
  },
  computed: {
    setoran() {
      return parseFloat(this.totalPenjualan) - parseFloat(this.bebanOperasional) - parseFloat(this.bebanGaji)
    },
    totalPenjualan() {
      let total = 0
      this.transaksiPenjualan.forEach(x => {
        total += parseFloat(x.grand_total)
      })
      return total
    },
    bebanOperasional() {
      let total = 0
      this.daftarBebanOperasional.forEach(x => {
        total += parseFloat(x.nominal)
      })
      return total
    },
    bebanGaji() {
      let total = 0
      this.daftarBebanGaji.forEach(x => {
        total += parseFloat(x.gaji_pokok) + parseFloat(x.uang_makan) + parseFloat(x.bonus)
      })
      return total
    },
    labaKotor() {
      return parseFloat(this.totalPenjualan) - parseFloat(this.hpp)
    },
    labaBersih() {
      return parseFloat(this.totalPenjualan) - parseFloat(this.hpp) - parseFloat(this.bebanOperasional) - parseFloat(this.bebanGaji)
    },
    sudahDiSetor() {
      let total = 0
      const b = this.daftarLaporanSetoran.filter(x => x.status === 'APPROVED')
      b.forEach(v => {
        total += parseFloat(v.nominal)
      })
      return total
    },
  },
  mounted() {
    this.loadLaporanCabang()
  },
  methods: {
    total_terima(x) {
      return parseFloat(x.gaji_pokok) + parseFloat(x.uang_makan) + parseFloat(x.bonus)
    },
    formatRupiah,
    print() {
      this.$refs.html2Pdf.generatePdf()
    },
    tahunChange() {
      this.hari = ''
      this.bulan = ''
      this.tanggal = `Tahun ${this.tahun}`
      this.loadLaporanCabang()
    },
    bulanChange() {
      this.hari = ''
      this.tahun = ''
      this.tanggal = `Bulan ${this.bulan.title} Tahun ${this.$moment().format('YYYY')}`
      this.loadLaporanCabang()
    },
    hariChange() {
      this.tahun = ''
      this.bulan = ''
      this.tanggal = `Tanggal ${this.$moment(this.hari).format('LL')}`
      this.loadLaporanCabang()
    },
    loadLaporanCabang() {
      this.isBusy = !this.isBusy
      this.$store
        .dispatch('app-laporan/laporanCabang', {
          cabang_id: this.userData.cabang_id,
          tahun: this.tahun,
          bulan: this.bulan ? this.bulan.value : '',
          hari: this.hari === '' ? '' : this.$moment(this.hari).format('YYYY-MM-DD'),
        })
        .then(res => {
          this.isBusy = !this.isBusy
          this.transaksiPenjualan = res.data.transaksi_penjualan
          this.hpp = res.data.hpp
          this.daftarBebanOperasional = res.data.daftar_beban_operasional
          this.daftarBebanGaji = res.data.daftar_beban_gaji
          this.daftarPersediaan = res.data.daftar_persediaan
          this.daftarLaporanSetoran = res.data.daftar_laporan_setoran
        })
    },
  },
  setup() {
    const userData = JSON.parse(localStorage.getItem('userData'))
    const transaksiPenjualan = ref([])
    const daftarBebanOperasional = ref([])
    const daftarBebanGaji = ref([])
    const daftarPersediaan = ref([])
    const daftarLaporanSetoran = ref([])
    const hpp = ref(0)
    const tablePenjualan = [
      { key: 'id', label: '#', sortable: true },
      { key: 'tanggal', sortable: true },
      { key: 'nomor_transaksi', sortable: true },
      { key: 'nama_pelanggan', sortable: true },
      { key: 'total_penjualan', sortable: true },
      { key: 'saldo', sortable: true },
    ]
    const tableBebanOperasional = [
      { key: 'id', label: '#', sortable: true },
      { key: 'tanggal', sortable: true },
      { key: 'nomor_jurnal', sortable: true },
      { key: 'catatan', sortable: true },
      { key: 'nominal', sortable: true },
    ]
    const tableBebanGaji = [
      { key: 'id', label: '#', sortable: true },
      { key: 'tanggal', sortable: true },
      { key: 'nama_pegawai', sortable: true },
      { key: 'gaji_pokok', sortable: true },
      { key: 'uang_makan', sortable: true },
      { key: 'bonus', sortable: true },
      { key: 'total_terima', sortable: true },
    ]
    const tableDataPersediaan = [
      { key: 'id', label: '#', sortable: true },
      { key: 'nama', sortable: true },
      { key: 'alamat', sortable: true },
      { key: 'saldo', sortable: true },
    ]
    const tableLaporanSetoran = [
      { key: 'id', label: '#', sortable: true },
      { key: 'tanggal', sortable: true },
      { key: 'nominal', sortable: true },
      { key: 'catatan', sortable: true },
      { key: 'status', sortable: true },
    ]

    return {
      transaksiPenjualan,
      daftarBebanOperasional,
      daftarBebanGaji,
      daftarPersediaan,
      daftarLaporanSetoran,
      hpp,
      userData,
      tablePenjualan,
      tableBebanOperasional,
      tableBebanGaji,
      tableDataPersediaan,
      tableLaporanSetoran,
    }
  },
}
</script>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
</style>
