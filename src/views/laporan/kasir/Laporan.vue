<template>
  <section>
    <b-row>
      <b-col lg="3" cols="3" sm="12">
        <b-card>
          <b-col cols="12" md="12">
            <b-form-group label="Nama Kasir">
              <v-select v-model="kasir" placeholder="Nama Kasir" :clearable="false" :options="kasirOption" label="pegawai" />
            </b-form-group>
          </b-col>
          <hr />

          <b-col cols="12" md="12">
            <b-form-group label="Tanggal">
              <b-form-datepicker
                placeholder="Tanggal"
                v-model="tanggal"
                locale="id"
                :date-format-options="{ year: 'numeric', month: 'numeric', day: 'numeric' }"
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
    </b-row>
  </section>
</template>

<script>
import { ref } from '@vue/composition-api'
import { BRow, BCol, BCard, BFormDatepicker, BButton, BFormGroup } from 'bootstrap-vue'
import Ripple from 'vue-ripple-directive'
import vSelect from 'vue-select'

export default {
  components: {
    vSelect,
    BRow,
    BCol,
    BCard,
    BFormDatepicker,
    BButton,
    BFormGroup,
  },
  directives: {
    Ripple,
  },
  mounted() {
    this.loadKasir()
  },
  methods: {
    loadKasir() {
      this.$store.dispatch('app-user/fetchListUser').then(res => {
        const filterCabang = res.data.filter(x => x.cabang_id === this.userData.cabang_id)
        const filterRole = filterCabang.filter(x => x.role === 'KASIR')
        this.kasirOption = filterRole
        if (this.userData.role.nama === 'KASIR') {
          this.kasirOption = filterRole.filter(x => x.id === this.userData.id)
        }
      })
    },
    print() {
      const loader = this.$loading.show()
      this.$store.dispatch('app-laporan/laporanKasir', {
        tanggal: this.tanggal,
        kasir_id: this.kasir.id,
      })
      loader.hide()
    },
  },
  setup() {
    const kasirOption = ref([])
    const kasir = ref({})
    const userData = JSON.parse(localStorage.getItem('userData'))
    const tanggal = null

    return {
      kasir,
      kasirOption,
      userData,
      tanggal,
    }
  },
}
</script>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
</style>
