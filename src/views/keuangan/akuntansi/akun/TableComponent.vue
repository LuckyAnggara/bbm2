<template>
  <section>
    <b-card :title="header.nama">
      <div class="d-flex mb-2">
        <span> Saldo : {{ formatRupiah(header.saldo) }} </span>
      </div>
      <b-table
        ref="refTable"
        responsive
        primary-key="id"
        :fields="subHeaderColumns"
        :items="dataTable"
        show-empty
        empty-text="Tidak ada data"
        class="position-relative"
      >
        <!-- Column: Tanggal -->
        <template #cell(no)="data">
          <span>
            {{ data.index + 1 }}
          </span>
        </template>

        <template #cell(sub_akun)="row">
          <!-- As `row.showDetails` is one-way, we call the toggleDetails function on @change -->
          <b-form-checkbox v-if="row.item.komponen.length !== 0" v-model="row.detailsShowing" @change="row.toggleDetails">
            {{ row.detailsShowing ? 'Hide' : 'Show' }}
          </b-form-checkbox>
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

        <!-- Column: Nama Akun -->
        <template #cell(nama)="data">
          <b-link :to="{ name: 'akuntansi-ledger-detail', params: { id: data.item.id } }" class="font-weight-bold" v-show="data.item.sub_header != 1">
            {{ data.item.nama }}
          </b-link>
          <span v-show="data.item.sub_header == 1">
            {{ data.item.nama }}
          </span>
        </template>

        <!-- Column: DEBIT KREDIT SALDO-->
        <template #cell(saldo)="data">
          <span :class="cekStatus(data.item.saldo)">
            {{ formatRupiah(data.item.saldo) }}
          </span>
        </template>

        <!-- full detail on click -->
        <template #row-details="data">
          <sub-table-component :komponen="data.item.komponen" :namaSubHeader="data.item.nama" />
        </template>
      </b-table>
    </b-card>
  </section>
</template>

<script>
import { BCard, BFormCheckbox, BTable, BLink } from 'bootstrap-vue'

import SubTableComponent from './SubTableComponent.vue'

export default {
  components: {
    SubTableComponent,
    BCard,
    BFormCheckbox,
    BTable,
    BLink,
  },
  props: {
    dataTable: {
      type: Array,
      required: true,
    },
    header: {
      type: Object,
      required: true,
    },
  },
  methods: {
    formatRupiah(value) {
      return `Rp. ${value.toFixed(0).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
    cekStatus(value) {
      if (value < 0) {
        return 'text-danger'
      }
      return ''
    },
  },

  setup() {
    const subHeaderColumns = [
      { key: 'no', sortable: true },
      { key: 'kode_akun', sortable: true },
      { label: 'nama akun', key: 'nama', sortable: true },
      { label: 'sifat', key: 'saldo_normal', sortable: true },
      { label: 'saldo', key: 'saldo', sortable: true },
      { key: 'sub_akun' },
    ]

    return {
      subHeaderColumns,
    }
  },
}
</script>
