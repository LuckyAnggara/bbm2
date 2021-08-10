<template>
  <section>
    <b-row>
      <!-- center align -->
      <b-col md="6" lg="4">
        <b-card title="Persediaan">
          <b-form-group label="Sampai Tanggal" label-for="tanggal">
            <b-form-datepicker v-model="tanggal" locale="id" />
          </b-form-group>
          <b-form-group label="Gudang" label-for="gudang">
            <v-select v-model="gudang" :options="listGudang" label="nama" :clearable="false" />
          </b-form-group>
          <b-button v-ripple.400="'rgba(113, 102, 240, 0.15)'" variant="success" @click="print">
            Print
          </b-button>
        </b-card>
      </b-col>
    </b-row>
  </section>
</template>

<script>
import { BRow, BCol, BCard, BButton, BFormGroup, BFormDatepicker } from 'bootstrap-vue'
import Ripple from 'vue-ripple-directive'
import vSelect from 'vue-select'

export default {
  components: {
    vSelect,
    BRow,
    BCol,
    BCard,
    BButton,
    BFormGroup,
    BFormDatepicker,
  },
  data() {
    return {
      tanggal: '',
      listGudang: [],
      gudang: null,
    }
  },
  directives: {
    Ripple,
  },
  mounted() {
    this.loadGudang()
  },
  methods: {
    loadGudang() {
      const user = JSON.parse(localStorage.getItem('userData'))
      const cabang = user.cabang_id
      this.$store
        .dispatch('app-persediaan/fetchListGudang', {
          cabang,
        })
        .then(res => {
          this.$store.commit('app-persediaan/SET_LIST_GUDANG', res.data)
          this.listGudang = this.$store.getters['app-persediaan/getListGudang']
        })
    },
    print() {
      const loader = this.$loading.show()
      const user = JSON.parse(localStorage.getItem('userData'))
      this.$store.dispatch('app-laporan/laporanPersediaan', {
        cabang: user.cabang_id,
        tanggal: this.tanggal,
        gudang: this.gudang.id,
      })
      loader.hide()
    },
  },
}
</script>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
</style>
