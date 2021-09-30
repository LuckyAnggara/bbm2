<template>
  <section>
    <b-row>
      <!-- center align -->
      <b-col md="9" lg="9">
        <b-card title="Performance Cabang">
          <b-table responsive :fields="tableColumns" :items="dataBarang" show-empty empty-text="Tidak ada data" class="position-relative"> </b-table>
        </b-card>
      </b-col>
    </b-row>
  </section>
</template>

<script>
import { BRow, BCol, BCard, BTable } from 'bootstrap-vue'
import Ripple from 'vue-ripple-directive'
// import vSelect from 'vue-select'

export default {
  components: {
    // vSelect,
    BRow,
    BCol,
    BCard,
    BTable,
  },
  data() {
    return {
      tanggal: '',
      listData: [],
      gudang: null,
    }
  },
  directives: {
    Ripple,
  },

  methods: {
    loadData() {
      const user = JSON.parse(localStorage.getItem('userData'))
      const cabang = user.cabang_id
      this.$store
        .dispatch('app-persediaan/fetchListGudang', {
          cabang,
        })
        .then(res => {
          this.$store.commit('app-persediaan/SET_LIST_GUDANG', res.data)
          this.listData = this.$store.getters['app-persediaan/getListGudang']
        })
    },
  },
  setup() {
    const tableColumns = [
      { key: 'id', label: '#', sortable: true },
      { key: 'nama_cabang', sortable: true },
      { key: 'penjualan', sortable: true },
      { key: 'hpp', sortable: true },
      { key: 'gross_margin', sortable: true },
      { key: 'beban', sortable: true },
      { key: 'laba', sortable: true },
    ]

    return {
      tableColumns,
    }
  },
}
</script>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
</style>
