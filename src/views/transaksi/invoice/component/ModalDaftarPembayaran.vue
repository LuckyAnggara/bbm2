<template>
  <b-modal size="xl" id="modal-daftar-pembayaran" title="Daftar Rincian Pembayaran" ok-title="Tutup" ok-only>
    <!-- <b-modal id="modal-default" ref="my-modal" ok-only ok-title="Submit" centered :title="detailBarang.nama"> -->
    <section>
      <b-card>
        <b-table
          id="my-table"
          ref="refTable"
          primary-key="id"
          :fields="tableColumns"
          :items="dataPembayaran"
          empty-text="Tidak ada data"
          class="position-relative"
        >
          <!-- Column: Id -->
          <template #cell(id)="data">
            <span>
              {{ data.index + 1 }}
            </span>
          </template>
          <!-- Column: Tanggal -->
          <template #cell(tanggal)="data">
            <span>
              {{ moment(data.item.created_at) }}
            </span>
          </template>
          <!-- Column: Nominal -->
          <template #cell(nominal)="data">
            <span>
              {{ formatRupiah(data.item.nominal) }}
            </span>
          </template>

          <!-- Column: Actions -->
          <template #cell(actions)="data">
            <div class="text-nowrap">
              <b-dropdown variant="link" toggle-class="p-0" no-caret>
                <template #button-content>
                  <feather-icon icon="MoreVerticalIcon" size="16" class="align-middle text-body" />
                </template>
                <b-dropdown-item :to="{ name: 'akuntansi-jurnal-detail', params: { id: data.item.nomor_jurnal } }">
                  <feather-icon icon="BookIcon" />
                  <span class="align-middle ml-50">Jurnal</span>
                </b-dropdown-item>
                <b-dropdown-item @click="destroy(data)">
                  <feather-icon icon="TrashIcon" />
                  <span class="align-middle ml-50">Delete</span>
                </b-dropdown-item>
              </b-dropdown>
            </div>
          </template>
        </b-table>
      </b-card>
    </section>
  </b-modal>
</template>

<script>
import router from '@/router'
import store from '@/store'
import { ref } from '@vue/composition-api'
import { BCard, BDropdown, BDropdownItem, BTable } from 'bootstrap-vue'

export default {
  components: {
    BCard,
    BDropdown,
    BDropdownItem,
    BTable,
  },
  mounted() {
    const { id } = router.currentRoute.params
    if (id !== undefined) {
      store.dispatch('app-transaksi-penjualan/fetchListPembayaran', id).then(res => {
        if (res.status === 200) {
          this.dataPembayaran = res.data
        }
      })
    }
  },
  methods: {
    moment(value) {
      return this.$moment(value).format('DD MMMM YYYY')
    },
    formatRupiah(value) {
      return `Rp. ${value.toFixed(0).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
  },

  setup() {
    const dataPembayaran = ref()
    const tableColumns = [
      { key: 'id', label: '#', sortable: false },
      { key: 'tanggal', sortable: false },
      { key: 'nominal', sortable: false },
      { key: 'cara_pembayaran', sortable: false },
      { key: 'catatan', sortable: false },
      { key: 'actions' },
    ]

    return {
      dataPembayaran,
      tableColumns,
    }
  },
}
</script>

<style lang="scss" scoped></style>
