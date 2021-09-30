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
          <b-col lg="12" cols="12"> <table-component :title="`PENDAPATAN`" :dataItem="dataPendapatan" /> </b-col>
          <b-col lg="12" cols="12"> <table-component :title="`BEBAN`" :dataItem="dataBeban" /> </b-col>
          <b-col lg="12" cols="12">
            <b-card title="Total Laba Berjalan" :footer="footerTitle" class="text-center" footer-class="text-muted">
              <h1 :class="labaRugiClass">{{ formatRupiah(labaRugi) }}</h1>
            </b-card>
          </b-col>
        </b-row>
      </b-col>
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
      labaRugi: 0,
    }
  },
  computed: {
    footerTitle() {
      return `Berdasarkan Data ${this.title}`
    },
    labaRugiClass() {
      if (this.labaRugi < 0) {
        return 'text-danger'
      }
      return 'text-success'
    },
  },
  mounted() {
    this.loadData()
  },
  methods: {
    setSelected() {
      this.loadData()
    },
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
    loadData() {
      const loader = this.$loading.show({
        container: this.$refs.dd,
      })
      store
        .dispatch('app-keuangan/fetchLabaRugi', {
          tahun: this.tahun,
          bulan: this.bulan ? this.bulan.value : '',
          hari: this.hari,
          cabang_id: this.user.cabang_id,
        })
        .then(res => {
          loader.hide()
          store.commit('app-keuangan/SET_LABA', res.data)
          this.dataPendapatan = store.getters['app-keuangan/getPendapatan']
          this.dataBeban = store.getters['app-keuangan/getBeban']
          this.labaRugi = res.data.labaRugi
        })
    },
  },

  setup() {
    const dataPendapatan = ref([])
    const dataBeban = ref([])
    const user = JSON.parse(localStorage.getItem('userData'))

    return {
      user,
      dataPendapatan,
      dataBeban,
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
