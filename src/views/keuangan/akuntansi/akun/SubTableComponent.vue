<template>
  <section>
    <b-card>
      <div class="d-flex mb-2">
        <span> Detail Komponen Sub Header {{ namaSubHeader }} </span>
      </div>
      <b-row class="mb-2">
        <b-col lg="9" cols="9">
          <b-table
            ref="refTable"
            responsive
            primary-key="id"
            :fields="field"
            :items="komponen"
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

            <!-- Column: Kode Akun -->
            <template #cell(kode_akun)="data">
              <b-link :to="{ name: 'akuntansi-ledger-detail', params: { id: data.item.id } }" class="font-weight-bold">
                {{ data.item.kode_akun }}
              </b-link>
            </template>

            <!-- Column: Nama Akun -->
            <template #cell(nama)="data">
              <b-link :to="{ name: 'akuntansi-ledger-detail', params: { id: data.item.id } }" class="font-weight-bold">
                {{ data.item.nama }}
              </b-link>
            </template>

            <!-- Column: DEBIT KREDIT SALDO-->
            <template #cell(saldo)="data">
              <span :class="cekStatus(data.item.saldo)">
                {{ formatRupiah(data.item.saldo) }}
              </span>
            </template>
          </b-table>
        </b-col>
      </b-row>
    </b-card>
  </section>
</template>

<script>
import { BRow, BCard, BCol, BTable, BLink } from 'bootstrap-vue'

export default {
  components: {
    BRow,
    BCard,
    BCol,
    BTable,
    BLink,
  },
  props: {
    komponen: {
      type: Array,
      required: true,
    },
    namaSubHeader: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      data: {},
    }
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
    const field = [
      { key: 'no', sortable: true },
      { key: 'kode_akun', sortable: true },
      { label: 'nama akun', key: 'nama', sortable: true },
      { label: 'saldo', key: 'saldo', sortable: true },
    ]

    return {
      field,
    }
  },
}
</script>
