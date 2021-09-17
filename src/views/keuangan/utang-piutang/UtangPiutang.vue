<template>
  <section>
    <b-tabs pills>
      <!-- general tab -->
      <b-tab active>
        <!-- title -->
        <template #title>
          <feather-icon icon="DollarSignIcon" size="24" class="mr-50" />
          <span class="font-weight-bold">Utang</span>
        </template>
        <utang-table />
      </b-tab>
      <b-tab>
        <!-- title -->
        <template #title>
          <feather-icon icon="DatabaseIcon" size="24" class="mr-50" />
          <span class="font-weight-bold">Piutang</span>
        </template>
        <piutang-table />
      </b-tab>
    </b-tabs>
  </section>
</template>

<script>
import { BTab, BTabs } from 'bootstrap-vue'
import UtangTable from './component/UtangTable.vue'
import PiutangTable from './component/PiutangTable.vue'
// import BulkPembayaran from './component/BulkPembayaran.vue'

export default {
  components: {
    BTab,
    BTabs,
    UtangTable,
    PiutangTable,
    // BulkPembayaran,
  },
}
</script>
