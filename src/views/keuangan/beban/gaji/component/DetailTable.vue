<template>
  <section>
    <b-table
      ref="refTable"
      responsive
      :fields="tableColumns"
      :items="dataList"
      :current-page="currentPage"
      show-empty
      empty-text="Tidak ada data"
      class="position-relative"
    >
      <!-- Column: ID -->
      <template #cell(no)="data">
        <span>{{ data.index + 1 }}</span>
      </template>
      <!-- Column: Tanggal -->
      <template #cell(tanggal)="data">
        <span>{{ moment(data.item.created_at) }}</span>
      </template>
      <!-- Column: Nominal -->
      <template #cell(nominal)="data">
        <span>{{ formatRupiah(data.item.nominal) }}</span>
      </template>

      <!-- Column: Actions -->
      <template #cell(action)="data">
        <div class="text-nowrap">
          <feather-icon
            :id="`jurnal-row-${data.item.id}-book-icon`"
            icon="EyeIcon"
            size="16"
            class="mx-1"
            @click="
              $router.push({
                name: 'akuntansi-jurnal-detail',
                params: { id: data.item.nomor_jurnal },
              })
            "
          />
          <b-tooltip title="Jurnal" :target="`jurnal-row-${data.item.id}-book-icon`" />

          <b-dropdown variant="link" toggle-class="p-0" no-caret>
            <template #button-content>
              <feather-icon icon="MoreVerticalIcon" size="16" class="align-middle text-body" />
            </template>
            <b-dropdown-item
              @click="
                $router.push({
                  name: 'akuntansi-jurnal-detail',
                  params: { id: data.item.nomor_jurnal },
                })
              "
            >
              <feather-icon icon="BookIcon" />
              <span class="align-middle ml-50">Jurnal</span>
            </b-dropdown-item>
            <b-dropdown-item @click="destroy(data)">
              <feather-icon icon="CastIcon" />
              <span class="align-middle ml-50">Print</span>
            </b-dropdown-item>
            <b-dropdown-item @click="destroy(data)">
              <feather-icon icon="TrashIcon" />
              <span class="align-middle ml-50">Delete</span>
            </b-dropdown-item>
          </b-dropdown>
        </div>
      </template>
    </b-table>
  </section>
</template>

<script>
import { ref } from '@vue/composition-api'
import { BTable, BTooltip, BDropdown, BDropdownItem } from 'bootstrap-vue'

export default {
  components: {
    BTooltip,
    BDropdown,
    BDropdownItem,
    BTable,
  },
  props: {
    dataList: {
      type: Array,
      required: true,
    },
  },
  methods: {
    destroy(data) {
      this.$emit('destroy', data)
    },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
    moment(value) {
      return this.$moment(value).format('DD MMMM YYYY')
    },
  },
  setup() {
    const tableColumns = [
      { key: 'no', sortable: false },
      {
        key: 'tanggal',
      },
      {
        key: 'kategori',
      },
      {
        key: 'uang_makan',
      },
      {
        key: 'bonus',
      },
      {
        key: 'berdasarkan',
      },
      {
        label: 'total',
        key: 'nominal',
      },
      {
        key: 'action',
      },
    ]

    // const searchQuery = ref('')
    const currentPage = ref(1)
    const isSortDirDesc = ref(false)

    return {
      tableColumns,
      isSortDirDesc,
      currentPage,
    }
  },
}
</script>
<style lang="scss" scoped>
@import '@core/scss/vue/libs/vue-select.scss';
.per-page-selector {
  width: 90px;
}
</style>
