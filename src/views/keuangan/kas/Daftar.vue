<template>
  <section>
    <b-row>
      <b-col lg="12" cols="12">
        <b-card>
          <b-table ref="refTable" responsive :fields="tableColumns" :items="listKas" class="position-relative">
            <template #cell(no)="data">
              <span>
                {{ data.index + 1 }}
              </span>
            </template>
            <!-- Column: Kode Akun -->
            <template #cell(kode_akun)="data">
              <b-link :to="{ name: 'akuntansi-ledger-detail', params: { id: data.item.id } }" class="font-weight-bold" v-show="data.item.sub_header != 1">
                {{ data.item.kode_akun }}
              </b-link>
              <span v-show="data.item.sub_header == 1">
                {{ data.item.kode_akun }}
              </span>
            </template>
            <template #cell(saldo)="data">
              <span :class="cekStatus(data.item.saldo)">
                {{ formatRupiah(data.item.saldo) }}
              </span>
            </template>
          </b-table>
        </b-card>
      </b-col>
    </b-row>
  </section>
</template>

<script>
import { formatRupiah } from '@core/utils/filter'
import { ref } from '@vue/composition-api'

import { BCard, BRow, BCol, BLink, BTable } from 'bootstrap-vue'

export default {
  components: {
    BCard,
    BRow,
    BCol,
    BLink,
    BTable,
  },
  mounted() {
    this.loadData()
  },
  methods: {
    formatRupiah,
    cekStatus(value) {
      if (value < 0) {
        return 'text-danger'
      }
      return ''
    },
    loadData() {
      this.$store
        .dispatch('app-cabang/fetchDataKas', {
          cabang_id: this.dataUser.cabang_id,
        })
        .then(res => {
          this.listKas = res.data
        })
    },
  },
  setup() {
    const listKas = ref([])
    const dataUser = JSON.parse(localStorage.getItem('userData'))
    const tableColumns = [
      { key: 'no', sortable: false },
      { key: 'kode_akun', sortable: false },
      {
        key: 'nama',
      },
      { key: 'saldo', sortable: true },
    ]

    return {
      listKas,
      dataUser,
      tableColumns,
    }
  },
}
</script>

<style lang="scss" scoped>
.per-page-selector {
  width: 90px;
}
</style>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
</style>
