<template>
  <section>
    <b-row>
      <!-- center align -->
      <b-col md="6" lg="4">
        <b-card title="Penjualan">
          <b-form-group label="Dari Tanggal" label-for="tanggal">
            <b-form-datepicker v-model="tanggal_awal" locale="id" />
          </b-form-group>
          <b-form-group label="Sampai Tanggal" label-for="tanggal">
            <b-form-datepicker v-model="tanggal_akhir" locale="id" />
          </b-form-group>
          <b-form-group label="Status" label-for="status">
            <v-select v-model="status" :options="statusOption" :clearable="false" />
          </b-form-group>
          <b-button v-ripple.400="'rgba(113, 102, 240, 0.15)'" variant="success" @click="print">
            Print
          </b-button>
        </b-card>
      </b-col>
      <b-col md="6" lg="4">
        <b-card title="Penjualan">
          <b-form-group label="Dari Tanggal" label-for="tanggal">
            <b-form-datepicker v-model="tanggal_awal" locale="id" />
          </b-form-group>
          <b-form-group label="Sampai Tanggal" label-for="tanggal">
            <b-form-datepicker v-model="tanggal_akhir" locale="id" />
          </b-form-group>
          <b-form-group label="Status" label-for="status">
            <v-select v-model="status" :options="statusOption" :clearable="false" />
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
      tanggal_awal: '',
      tanggal_akhir: '',
      statusOption: ['SEMUA', 'LUNAS', 'BELUM LUNAS'],
      status: 'SEMUA',
    }
  },
  directives: {
    Ripple,
  },
  methods: {
    print() {
      const loader = this.$loading.show()
      const user = JSON.parse(localStorage.getItem('userData'))
      this.$store.dispatch('app-laporan/laporanTransaksiPenjualan', {
        cabang: user.cabang_id,
        tanggal_awal: this.tanggal_awal,
        tanggal_akhir: this.tanggal_akhir,
        status: this.status,
      })
      loader.hide()
    },
  },
}
</script>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
</style>
