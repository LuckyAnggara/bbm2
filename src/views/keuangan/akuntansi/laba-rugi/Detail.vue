<template>
  <section>
    <b-row class="match-height">
      <b-col lg="12" cols="12">
        <b-card>
          <b-col cols="12" md="6" class="d-flex align-items-center justify-content-start mb-1 mb-md-0">
            <label>Tahun Buku</label>
            <v-select v-model="tahun" :options="option" :clearable="false" @input="setSelected" class="per-page-selector d-inline-block ml-50 mr-1" />
            <b-button variant="success" class="d-inline-block ml-50 mr-1">
              Print Data
            </b-button>
          </b-col>
        </b-card>
      </b-col>
    </b-row>

    <div>
      <b-row class="match-height">
        <b-col lg="6" cols="12"> <table-component :title="`Pendapatan`" :dataItem="dataPendapatan" /> </b-col>
        <b-col lg="6" cols="12">
          <b-card title="Total Laba Berjalan" :footer="footerTitle" class="text-center" footer-class="text-muted">
            <b-card-text>
              <h1 :class="labaRugiClass">{{ formatRupiah(labaRugi) }}</h1>
            </b-card-text>
          </b-card>
        </b-col>
      </b-row>
      <b-row>
        <b-col lg="6" cols="12"> <table-component :title="`Beban`" :dataItem="dataBeban" /> </b-col>
      </b-row>
    </div>
  </section>
</template>

<script>
import store from '@/store'
import { ref } from '@vue/composition-api'

import { BButton, BCard, BCardText, BRow, BCol } from 'bootstrap-vue'
import vSelect from 'vue-select'
import TableComponent from './component/Table.vue'

export default {
  components: {
    TableComponent,
    vSelect,
    BButton,
    BCard,
    BCardText,
    BRow,
    BCol,
  },
  data() {
    return {
      tahun: '2021',
      option: ['2021', '2022', '2023'],
      labaRugi: 0,
    }
  },
  computed: {
    footerTitle() {
      return `Berdasarkan Data Tahun ${this.tahun} berjalan`
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
