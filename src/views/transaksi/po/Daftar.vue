<template>
  <section>
    <b-tabs>
      <!-- general tab -->
      <b-tab active>
        <!-- title -->
        <template #title>
          <feather-icon icon="DollarSignIcon" size="24" class="mr-50" />
          <span class="font-weight-bold">P.O Keluar</span>
        </template>
        <keluar />
      </b-tab>
      <b-tab>
        <!-- title -->
        <template #title>
          <feather-icon icon="DatabaseIcon" size="24" class="mr-50" />
          <span class="font-weight-bold">P.O Masuk</span>
        </template>
        <masuk />
      </b-tab>
    </b-tabs>
  </section>
</template>

<script>
import { BTab, BTabs } from 'bootstrap-vue'
import Keluar from './component/Keluar.vue'
import Masuk from './component/Masuk.vue'

export default {
  components: {
    BTab,
    BTabs,
    Keluar,
    Masuk,
  },
}
</script>
