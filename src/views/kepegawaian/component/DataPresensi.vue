<template>
  <section>
    <div ref="container">
      <template>
        <b-row>
          <b-col lg="12" cols="12">
            <div class="mt-2">
              <div class="mb-2">
                <!-- Table Top -->
                <b-row>
                  <!-- Per Page -->
                  <b-col cols="12" md="6" class="d-flex align-items-center justify-content-start mb-1 mb-md-0">
                    <label>Bulan</label>
                    <v-select
                      :value="bulan.title"
                      v-model="bulan.value"
                      :reduce="x => x.value"
                      label="title"
                      :options="bulanOptions"
                      :clearable="false"
                      class="per-page-selector d-inline-block ml-50 mr-1"
                    />
                  </b-col>
                </b-row>
              </div>
              <b-table
                ref="refTable"
                responsive
                primary-key="id"
                :fields="tableColumns"
                :items="dataPresensi"
                empty-text="Tidak ada data"
                class="position-relative"
              >
                <!-- Column: Tanggal -->
                <template #cell(tanggal)="data">
                  <span>
                    {{ $moment(data.item.tanggal).format('DD MMMM YYYY') }}
                  </span>
                </template>
                <!-- Column: Jam Masuk -->
                <template #cell(jam_masuk)="data">
                  <span>
                    {{ data.item.jam_masuk !== null ? $moment(data.item.jam_masuk).format('LT') : '-' }}
                  </span>
                </template>
                <!-- Column: Jam Keluar -->
                <template #cell(jam_keluar)="data">
                  <span>
                    {{ data.item.jam_keluar !== null ? $moment(data.item.jam_keluar).format('LT') : '-' }}
                  </span>
                </template>
              </b-table>
            </div>
          </b-col>
        </b-row>
      </template>
    </div>
  </section>
</template>

<script>
import store from '@/store'
import { ref } from '@vue/composition-api'
import { BTable, BRow, BCol } from 'bootstrap-vue'
import vSelect from 'vue-select'

export default {
  components: {
    BTable,
    BRow,
    BCol,
    vSelect,
  },
  data() {
    return {}
  },
  watch: {
    bulan: {
      deep: true,
      handler() {
        this.setData()
      },
    },
  },
  mounted() {
    const d = new Date()
    const m = d.getMonth() + 1
    const ff = this.bulanOptions.findIndex(x => x.value === m.toString())
    this.bulan.value = this.bulanOptions[ff].value
    this.bulan.title = this.bulanOptions[ff].title
  },
  methods: {
    setData() {
      const { id } = this.$router.currentRoute.params
      store.dispatch('app-pegawai/fetchListPresensi', { pegawai_id: id, bulan: this.bulan.value }).then(res => {
        if (res.status === 200) {
          store.commit('app-pegawai/SET_DETAIL_PRESENSI', res.data)
          this.dataPresensi = store.getters['app-pegawai/getDetailPresensi']
        }
      })
    },
  },

  setup() {
    const dataPresensi = ref()
    const bulan = ref({
      title: '',
      value: '',
    })
    const bulanOptions = [
      { title: 'Januari', value: '1' },
      { title: 'Februari', value: '2' },
      { title: 'Maret', value: '3' },
      { title: 'April', value: '4' },
      { title: 'Mei', value: '5' },
      { title: 'Juni', value: '6' },
      { title: 'Juli', value: '7' },
      { title: 'Agustus', value: '8' },
      { title: 'September', value: '9' },
      { title: 'Oktober', value: '10' },
      { title: 'November', value: '11' },
      { title: 'Desember', value: '12' },
    ]
    const tableColumns = [
      { key: 'tanggal', sortable: false },
      { key: 'jam_masuk', sortable: false },
      { key: 'jam_keluar', sortable: false },
      { key: 'catatan', sortable: false },
    ]

    return {
      bulan,
      dataPresensi,
      bulanOptions,
      tableColumns,
    }
  },
}
</script>

<style lang="scss" scoped>
.per-page-selector {
  width: 200px;
}

.barang-filter-select {
  min-width: 190px;

  ::v-deep .vs__selected-options {
    flex-wrap: nowrap;
  }

  ::v-deep .vs__selected {
    width: 100px;
  }
}
</style>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
</style>
