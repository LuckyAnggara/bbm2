<template>
  <section>
    <b-tabs v-model="tabIndex" vertical content-class="col-12 col-md-10 mt-1 mt-md-0" pills nav-wrapper-class="col-md-2 col-12" nav-class="nav-left">
      <!-- general tab -->
      <b-tab>
        <!-- title -->
        <template #title>
          <feather-icon icon="DollarSignIcon" size="18" class="mr-50" />
          <span class="font-weight-bold">Kas Bank</span>
        </template>
        <kas-bank @changetab="changeTab" />
      </b-tab>
      <b-tab>
        <!-- title -->
        <template #title>
          <feather-icon icon="DatabaseIcon" size="18" class="mr-50" />
          <span class="font-weight-bold">Kirim</span>
        </template>
        <kirim-setor />
      </b-tab>
    </b-tabs>
  </section>
</template>

<script>
import { BTab, BTabs } from 'bootstrap-vue'
import KasBank from './component/KasBank.vue'
import KirimSetor from './component/KirimSetor.vue'

export default {
  components: {
    BTab,
    BTabs,
    KasBank,
    KirimSetor,
    // TerimaSetor,
  },
  data() {
    return {
      tabIndex: 0,
    }
  },
  methods: {
    changeTab() {
      this.tabIndex = 1
    },
  },
}
</script>
