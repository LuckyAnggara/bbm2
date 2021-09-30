<template>
  <section>
    <b-row>
      <b-col lg="4" cols="4" sm="12">
        <b-card>
          <b-col cols="12" md="12">
            <b-form-group label="Tahunan" label-for="bank" label-cols-md="4">
              <v-select v-model="tahun" placeholder="Berdasarkan Tahunan" :clearable="true" :options="tahunOption" @input="tahunChange()" />
            </b-form-group>
          </b-col>

          <hr />
          <b-col cols="12" md="12">
            <b-form-group label="Bulanan" label-for="bank" label-cols-md="4">
              <v-select v-model="bulan" placeholder="Berdasarkan Bulanan" label="title" :clearable="true" :options="bulanOption" @input="bulanChange()" />
            </b-form-group>
          </b-col>
          <hr />
          <b-col cols="12" md="12">
            <b-form-group label="Harian" label-for="bank" label-cols-md="4">
              <b-form-datepicker
                placeholder="Berdasarkan Harian"
                v-model="hari"
                locale="id"
                :date-format-options="{ year: 'numeric', month: 'numeric', day: 'numeric' }"
                @input="hariChange()"
              />
            </b-form-group>
          </b-col>
          <hr />
          <b-col offset-md="4">
            <b-button variant="outline-secondary">
              Download
            </b-button>
          </b-col>
        </b-card>
      </b-col>
      <b-col lg="8" cols="8" sm="12">
        <b-row>
          <!-- ASSET -->
          <b-col lg="12" cols="12" sm="12">
            <table-component :title="`Assets`" :dataItem="dataAssets" />
          </b-col>
          <!-- END ASSET -->
          <!-- TOTAL ASSET -->
          <b-col lg="12" cols="12" sm="12">
            <b-card class="text-center">
              <h3>
                Total Aset = <span class="text-primary">{{ totalAssets }}</span>
              </h3>
            </b-card>
          </b-col>
          <!-- END TOTAL ASSET -->
          <!-- LIABILIETIES -->
          <b-col lg="12" cols="12" sm="12">
            <table-component :title="`Liabilities`" :dataItem="dataLiabilities" />
          </b-col>
          <!-- END LIABILIETIES -->
          <!-- EQUITY -->
          <b-col lg="12" cols="12" sm="12">
            <table-component :title="`Equity`" :dataItem="dataEquity" />
          </b-col>
          <!-- END EQUITY -->
          <!-- TOTAL LIABLIETIES + EQUITY -->
          <b-col lg="12" cols="12" sm="12">
            <b-card class="text-center">
              <h3>
                Total Liabilities + Equity = <span class="text-primary">{{ totalLiabilities }}</span>
              </h3>
            </b-card>
          </b-col>
          <!-- END TOTAL ASSET -->
        </b-row>
      </b-col>
      <b-col lg="8" cols="8"> </b-col>
    </b-row>
  </section>
</template>

<script>
import store from '@/store'
import { ref } from '@vue/composition-api'

import { BFormDatepicker, BFormGroup, BButton, BCard, BRow, BCol } from 'bootstrap-vue'
import vSelect from 'vue-select'

import TableComponent from './component/Table.vue'

export default {
  components: {
    BFormDatepicker,
    BFormGroup,
    TableComponent,
    vSelect,
    BButton,
    BCard,
    BRow,
    BCol,
  },
  data() {
    return {
      title: 'Tahun 2021 Berjalan',
      hari: '',
      tahun: new Date().getFullYear(),
      bulan: '',
      tahunOption: ['2021', '2022', '2023'],
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
  mounted() {
    this.loadData()
  },
  computed: {
    totalAssets() {
      let saldo = 0
      this.dataAssets.forEach(x => {
        saldo += x.saldo
      })
      return this.formatRupiah(saldo)
    },
    totalLiabilities() {
      let saldoEquity = 0
      let saldoLibilities = 0

      this.dataLiabilities.forEach(x => {
        saldoLibilities += x.saldo
      })

      this.dataEquity.forEach(y => {
        saldoEquity += y.saldo
      })
      return this.formatRupiah(parseFloat(saldoLibilities) + parseFloat(saldoEquity))
    },
  },
  methods: {
    tahunChange() {
      this.hari = ''
      this.bulan = ''
      this.title = `Tahun ${this.tahun} Berjalan`
      this.loadData()
    },
    bulanChange() {
      this.hari = ''
      this.tahun = ''
      this.title = `Bulan ${this.bulan.title} Berjalan`
      this.loadData()
    },
    hariChange() {
      this.tahun = ''
      this.bulan = ''
      this.title = `Tanggal ${this.$moment(this.hari).format('LL')}`
      this.loadData()
    },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
    setSelected() {
      this.loadData()
    },
    loadData() {
      const loader = this.$loading.show({})
      store
        .dispatch('app-keuangan/fetchNeraca', {
          tahun: this.tahun,
          bulan: this.bulan ? this.bulan.value : '',
          hari: this.hari,
          cabang_id: this.userData.cabang_id,
        })
        .then(res => {
          loader.hide()
          store.commit('app-keuangan/SET_NERACA', res.data)
          this.dataAssets = store.getters['app-keuangan/getNeracaAssets']
          this.dataLiabilities = store.getters['app-keuangan/getNeracaLiabilities']
          this.dataEquity = store.getters['app-keuangan/getNeracaEquity']
        })
    },
  },
  setup() {
    const dataAssets = ref([])
    const dataLiabilities = ref([])
    const dataEquity = ref([])
    const userData = JSON.parse(localStorage.getItem('userData'))

    return {
      userData,
      dataAssets,
      dataLiabilities,
      dataEquity,
    }
  },
}
</script>

<style lang="scss" scoped>
.per-page-selector {
  width: 180px;
}
</style>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
</style>
