<template>
  <section>
    <b-modal size="lg" id="modal-daftar-pembayaran-pembelian" title="Daftar Rincian Pembayaran" ok-title="Tutup" ok-only lazy>
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
                  <b-dropdown-item @click="destroy(data)" v-show="data.item.catatan === 'PEMBAYARAN DOWN PAYMENT' ? false : true">
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
  </section>
</template>

<script>
import store from '@/store'
import { BCard, BDropdown, BDropdownItem, BTable } from 'bootstrap-vue'

export default {
  components: {
    BCard,
    BDropdown,
    BDropdownItem,
    BTable,
  },
  computed: {
    dataPembayaran() {
      return store.getters['app-transaksi-pembelian/getListPembayaran']
    },
  },
  methods: {
    moment(value) {
      return this.$moment(value).format('DD MMMM YYYY')
    },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
    destroy(data) {
      const { id } = data.item
      this.$swal({
        title: 'Delete data ?',
        text: 'Data transaksi pembayaran akan di hapus!',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Ya!',
        customClass: {
          confirmButton: 'btn btn-primary',
          cancelButton: 'btn btn-outline-danger ml-1',
        },
        buttonsStyling: false,
      }).then(result => {
        if (result.value) {
          store
            .dispatch('app-transaksi-pembelian/deletePembayaranUtang', {
              id,
            })
            .then(x => {
              if (x.status === 200) {
                store.commit('app-transaksi-pembelian/UPDATE_REMOVE_PEMBAYARAN', data.index)
                store.commit('app-transaksi-pembelian/UPDATE_PEMBAYARAN', {
                  jenis: 'HAPUS',
                  nominal: data.item.nominal,
                })
                this.$swal({
                  icon: 'success',
                  title: 'Transaksi sudah di Delete!',
                  customClass: {
                    confirmButton: 'btn btn-success',
                  },
                })
              } else {
                this.$swal({
                  icon: 'error',
                  title: 'Oopps!! Kesalahan',
                  customClass: {
                    confirmButton: 'btn btn-success',
                  },
                })
              }
            })
        }
      })
    },
  },

  setup() {
    const tableColumns = [
      { key: 'id', label: '#', sortable: false },
      { key: 'tanggal', sortable: false },
      { key: 'nominal', sortable: false },
      { key: 'cara_pembayaran', sortable: false },
      { key: 'catatan', sortable: false },
      { key: 'actions' },
    ]

    return {
      tableColumns,
    }
  },
}
</script>

<style lang="scss" scoped></style>
