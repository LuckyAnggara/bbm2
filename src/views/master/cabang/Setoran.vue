<template>
  <section>
    <b-row>
      <b-col lg="3" cols="3" sm="12">
        <b-card>
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
          <hr />
          <b-col offset-md="3">
            <b-button variant="outline-primary" @click="generate">
              Download
            </b-button>
          </b-col>
        </b-card>
      </b-col>
      <b-col cols="9" lg="9" sm="12" ref="loading">
        <b-card :title="title">
          <b-table responsive :fields="tableColumns" :items="listDataSetoran" show-empty empty-text="Tidak ada data" class="position-relative">
            <template #cell(nama_cabang)="data">
              {{ data.item.nama }}
            </template>
            <template #cell(setoran)="data">
              {{ terbuku(data.item) }}
            </template>
          </b-table>
        </b-card>
      </b-col>
    </b-row>
  </section>
</template>

<script>
import { BRow, BCol, BCard, BTable, BFormDatepicker, BFormGroup, BButton } from 'bootstrap-vue'
import { formatRupiah } from '@core/utils/filter'
import Ripple from 'vue-ripple-directive'

export default {
  components: {
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
      title: 'Data Setoran',
      listDataSetoran: [],
      hari: this.$moment(new Date()).format('Y-MM-DD'),
    }
  },

  directives: {
    Ripple,
  },
  mounted() {
    this.loadData()
  },
  methods: {
    terbuku(x) {
      const a = parseFloat(x.penjualan) + parseFloat(x.pendapatan_lainnya) - parseFloat(x.total_beban)
      return this.formatRupiah(a)
    },
    hariChange() {
      this.loadData()
    },
    generate() {
      this.loadData()
    },
    formatRupiah,
    loadData() {
      const loader = this.$loading.show({
        container: this.$refs.loading,
      })
      this.$store
        .dispatch('app-cabang/fetchDataPerformanceAll', {
          tahun: '',
          bulan: '',
          hari: this.hari,
        })
        .then(res => {
          loader.hide()
          this.$store.commit('app-cabang/SET_LIST_DATA_PERFORMANCE', res.data)
          this.listDataSetoran = this.$store.getters['app-cabang/getListDataPerformance']
        })
    },
  },
  setup() {
    const tableColumns = [{ key: 'nama_cabang' }, { key: 'setoran' }, { key: 'pelaporan' }, { key: 'terbuku' }, { key: 'sisa' }, { key: 'action' }]
    const userData = JSON.parse(localStorage.getItem('userData'))

    return {
      userData,
      tableColumns,
    }
  },
}
</script>
