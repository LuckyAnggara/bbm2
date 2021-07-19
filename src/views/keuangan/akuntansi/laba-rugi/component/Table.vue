<template>
  <section>
    <b-card :title="title">
      <b-table
        ref="refTable"
        responsive
        :fixed="true"
        :borderless="true"
        :fields="columns"
        :items="dataItem"
        show-empty
        empty-text="Tidak ada data"
        class="position-relative"
      >
        <!-- Column: Nama Akun -->
        <template #cell(nama)="data">
          <b-link v-if="data.item.align !== 1" :to="{ name: 'akuntansi-ledger-detail', params: { id: data.item.id } }">
            {{ data.item.nama }}
          </b-link>
          <p v-if="data.item.align === 1" class="font-weight-bold text-right">
            {{ data.item.nama }}
          </p>
        </template>

        <!-- Column: DEBIT KREDIT SALDO-->
        <template #cell(saldo)="data">
          <p v-if="data.item.align !== 1">
            <span :class="warna(data.item.saldo_normal)">{{ formatRupiah(data.item.saldo) }}</span>
          </p>
          <p v-if="data.item.align === 1" class="font-weight-bold text-right">
            {{ formatRupiah(data.item.saldo) }}
          </p>
        </template>
      </b-table>
    </b-card>
  </section>
</template>

<script>
import { BTable, BCard, BLink } from 'bootstrap-vue'

export default {
  components: {
    BTable,
    BCard,
    BLink,
  },
  data() {
    return {
      tahun: '2021',
      option: ['2021', '2022', '2023'],
    }
  },
  props: {
    dataItem: {
      type: Array,
      required: true,
    },
    title: {
      type: String,
      required: true,
    },
  },
  methods: {
    warna(value) {
      if (value === 'KREDIT') {
        return ''
      }
      return 'text-danger'
    },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
  },
  setup() {
    const columns = [
      { key: 'nama', sortable: false },
      { key: 'saldo', sortable: false },
    ]

    return {
      columns,
    }
  },
}
</script>
