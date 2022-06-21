<template>
  <section>
    <b-tabs pills>
      <!-- general tab -->
      <b-tab active>
        <!-- title -->
        <template #title>
          <feather-icon icon="DollarSignIcon" size="24" class="mr-50" />
          <span class="font-weight-bold">Utang Dagang</span>
        </template>
        <utang-table />
      </b-tab>
      <b-tab>
        <!-- title -->
        <template #title>
          <feather-icon icon="DatabaseIcon" size="24" class="mr-50" />
          <span class="font-weight-bold">Piutang Dagang</span>
        </template>
        <piutang-table />
      </b-tab>
      <b-tab active>
        <!-- title -->
        <template #title>
          <feather-icon icon="DollarSignIcon" size="24" class="mr-50" />
          <span class="font-weight-bold">Utang P.O</span>
        </template>
        <utang-po />
      </b-tab>
    </b-tabs>

    <modal-daftar-pembayaran />
  </section>
</template>

<script>
import { BTab, BTabs } from 'bootstrap-vue'
import ModalDaftarPembayaran from '@/views/transaksi/invoice/component/ModalDaftarPembayaranPenjualan.vue'
import UtangTable from './component/UtangTable.vue'
import PiutangTable from './component/PiutangTable.vue'
import UtangPo from './component/UtangPO.vue'

// import BulkPembayaran from './component/BulkPembayaran.vue'

export default {
  components: {
    BTab,
    BTabs,
    UtangTable,
    PiutangTable,
    UtangPo,
    ModalDaftarPembayaran,
    // BulkPembayaran,
  },
}
</script>
