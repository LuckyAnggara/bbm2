<template>
  <section>
    <b-tabs vertical content-class="col-12 col-md-10 mt-1 mt-md-0" pills nav-wrapper-class="col-md-2 col-12" nav-class="nav-left">
      <!-- general tab -->
      <b-tab active>
        <!-- title -->
        <template #title>
          <feather-icon icon="DollarSignIcon" size="18" class="mr-50" />
          <span class="font-weight-bold">Kas Tunai</span>
        </template>
        <kas-tunai />
      </b-tab>
      <b-tab>
        <!-- title -->
        <template #title>
          <feather-icon icon="DatabaseIcon" size="18" class="mr-50" />
          <span class="font-weight-bold">Kirim</span>
        </template>
        <kirim-setor />
      </b-tab>
      <!-- <b-tab>
        <template #title>
          <feather-icon icon="DatabaseIcon" size="18" class="mr-50" />
          <span class="font-weight-bold">Terima</span>
        </template>
        <terima-setor />
      </b-tab>  -->
    </b-tabs>
  </section>
</template>

<script>
import { BTab, BTabs } from 'bootstrap-vue'
import KasTunai from './component/KasTunai.vue'
import KirimSetor from './component/KirimSetor.vue'
// import TerimaSetor from './component/TerimaSetor.vue'

export default {
  components: {
    BTab,
    BTabs,
    KasTunai,
    KirimSetor,
    // TerimaSetor,
  },
}
</script>
