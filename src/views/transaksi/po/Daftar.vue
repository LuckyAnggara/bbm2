<template>
  <section>
    <b-tabs>
      <!-- general tab -->
      <b-tab active>
        <!-- title -->
        <template #title>
          <feather-icon icon="DatabaseIcon" size="24" class="mr-50" />
          <span class="font-weight-bold mr-1">P.O Keluar</span>
          <b-badge pill variant="danger" v-if="totalKeluar !== 0 ? true : false">{{ totalKeluar }}</b-badge>
        </template>
        <keluar />
      </b-tab>
      <b-tab>
        <!-- title -->
        <template #title>
          <feather-icon icon="DatabaseIcon" size="24" class="mr-50" />
          <span class="font-weight-bold mr-1">P.O Masuk </span>
          <b-badge pill variant="danger" v-if="totalMasuk !== 0 ? true : false">{{ totalMasuk }}</b-badge>
        </template>
        <masuk />
      </b-tab>
    </b-tabs>
  </section>
</template>

<script>
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
  computed: {
    totalMasuk() {
      return this.$store.getters['app-po/getListPOMasuk'].filter(x => x.status === 'SEND').length
    },
    totalKeluar() {
      return this.$store.getters['app-po/getListPOKeluar'].filter(x => x.status === 'SEND' || x.status === 'APPROVED').length
    },
  },
}
</script>
