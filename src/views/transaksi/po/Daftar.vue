<template>
  <section>
    <b-tabs>
      <!-- general tab -->
      <b-tab active>
        <!-- title -->
        <template #title>
          <feather-icon icon="DatabaseIcon" size="24" class="mr-50" />
          <span class="font-weight-bold">P.O Keluar</span>
        </template>
        <keluar />
      </b-tab>
      <b-tab>
        <!-- title -->
        <template #title>
          <feather-icon icon="DatabaseIcon" size="24" class="mr-50" />
          <span class="font-weight-bold mr-1">P.O Masuk </span>
          <b-badge pill variant="danger">{{ totalMasuk }}</b-badge>
        </template>
        <masuk />
      </b-tab>
    </b-tabs>
  </section>
</template>

<script>
import { ref } from '@vue/composition-api'
import { BBadge, BTab, BTabs } from 'bootstrap-vue'
import Keluar from './component/Keluar.vue'
import Masuk from './component/Masuk.vue'

export default {
  components: {
    BBadge,
    BTab,
    BTabs,
    Keluar,
    Masuk,
  },
  created() {
    this.totalMasuk = this.$store.getters['app-po/getListPOMasuk'].filter(x => x.status_po_masuk === 'BELUM DIBACA').length
  },
  setup() {
    const totalMasuk = ref(0)

    return {
      totalMasuk,
    }
  },
}
</script>
