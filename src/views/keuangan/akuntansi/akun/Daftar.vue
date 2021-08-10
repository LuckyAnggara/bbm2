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
          <div v-for="item in dataAkun" :key="item.id">
            <table-component :header="item" :dataTable="item.subheader" />
          </div>
        </b-card>
      </b-col>
    </b-row>
  </section>
</template>

<script>
import store from '@/store'
import { ref } from '@vue/composition-api'
import { BButton, BCard, BRow, BCol } from 'bootstrap-vue'
import vSelect from 'vue-select'

import TableComponent from './TableComponent.vue'

export default {
  components: {
    vSelect,
    BButton,
    BCard,
    TableComponent,
    BRow,
    BCol,
  },
  data() {
    return {
      tahun: '2021',
      option: ['2021', '2022', '2023'],
    }
  },
  mounted() {
    this.loadAkun()
  },
  methods: {
    setSelected() {
      this.loadAkun()
    },
    loadAkun() {
      const user = JSON.parse(localStorage.getItem('userData'))
      store
        .dispatch('app-keuangan/fetchListAkun', {
          tahun: this.tahun,
          cabang: user.cabang_id,
        })
        .then(res => {
          store.commit('app-keuangan/SET_LIST_AKUN', res.data)
          this.dataAkun = store.getters['app-keuangan/getListAkun'].filter(x => x.subheader.filter(y => y.saldo !== 0))
        })
    },
  },
  setup() {
    const dataAkun = ref([])
    return {
      dataAkun,
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
