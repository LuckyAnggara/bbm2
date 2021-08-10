<template>
  <!-- Table Container Card -->

  <section></section>
</template>

<script>
import { ref } from '@vue/composition-api'

import { BRow, BCol, BFormInput, BButton, BTable, BPagination, BDropdown, BDropdownItem, BTooltip } from 'bootstrap-vue'

export default {
  components: {
    BRow,
    BCol,
    BFormInput,
    BButton,
    BTable,

    BPagination,
    BDropdown,
    BDropdownItem,
    BTooltip,
    vSelect,
  },
  data() {
    return {
      kontak: [],
      data: [],
      searchQuery: '',
      refTable: null,
    }
  },
  props: {
    dataKontak: {
      type: Array,
      required: true,
    },
  },
  watch: {
    searchQuery(query) {
      if (query === '') {
        this.kontak = this.data
      } else {
        this.kontak = this.data.filter(item => item.nama.toLowerCase().indexOf(query.toLowerCase()) > -1)
      }
      this.totalData = this.kontak.length
    },
    dataKontak() {
      this.kontak = this.dataKontak
      this.data = this.dataKontak
      this.totalData = this.dataKontak.length
    },
  },
  computed: {
    // kontak() {
    //   return this.dataKontak.filter(item => item.tipe === this.filter)
    // },
    // data() {
    //   return this.dataKontak.filter(item => item.tipe === this.filter)
    // },
    dataMeta() {
      const localItemsCount = this.$refs.refTable ? this.$refs.refTable.computedItems.length : 0
      return {
        from: this.perPage * (this.currentPage - 1) + (localItemsCount ? 1 : 0),
        to: this.perPage * (this.currentPage - 1) + localItemsCount,
        of: this.totalData,
      }
    },
  },
  methods: {
    moment(value) {
      return this.$moment(value).format('DD MMMM YYYY')
    },
  },
  setup() {
    const tableColumns = [
      { key: 'id', label: '#', sortable: true },
      { key: 'nama', sortable: true },
      { key: 'telepon', sortable: true },
      { key: 'alamat', sortable: true },
      { key: 'action' },
    ]
    // const searchQuery = ref('')
    const perPage = ref(10)
    const totalData = ref(0)
    const currentPage = ref(1)
    const perPageOptions = [10, 25, 50, 100]
    const sortBy = ref('id')
    const isSortDirDesc = ref(true)
    const statusFilter = ref(null)

    return {
      tableColumns,
      // searchQuery,
      perPage,
      isSortDirDesc,
      currentPage,
      totalData,
      perPageOptions,
      sortBy,
      statusFilter,
    }
  },
}
</script>

<style lang="scss" scoped>
.per-page-selector {
  width: 90px;
}

.kontak-filter-select {
  min-width: 190px;

  ::v-deep .vs__selected-options {
    flex-wrap: nowrap;
  }

  ::v-deep .vs__selected {
    width: 100px;
  }
}
</style>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
</style>
