<template>
  <section>
    <b-row>
      <b-col cols="12" md="9" xl="9">
        <b-card :title="`Transfer Persediaan Tanggal : ${tanggal}`">
          <b-form-group label="Dari Gudang" label-for="dari">
            <b-form-input v-model="detailTransfer.dari.nama" type="text" readonly />
          </b-form-group>
          <b-form-group label="Ke Gudang" label-for="ke">
            <b-form-input v-model="detailTransfer.ke.nama" type="text" readonly />
          </b-form-group>
          <b-form-group label="Tanggal Transfer" label-for="tanggalTransfer">
            <b-form-input v-model="tanggal" type="text" readonly />
          </b-form-group>
          <b-form-group label="Catatan" label-for="catatan">
            <b-form-textarea placeholder="Catatan" v-model="detailTransfer.catatan" type="text" readonly />
          </b-form-group>
          <b-form-group label="Rincian Barang" label-for="rincianbarang">
            <b-table show-empty empty-text="Tidak ada data" class="position-relative" :items="detailTransfer.detail" :fields="tableColumns">
              <!-- Column: Nama -->
              <template #cell(nama)="data">
                <span>
                  {{ `${data.item.kode_barang} - ${data.item.nama}` }}
                </span>
              </template>
            </b-table>
          </b-form-group>
        </b-card>
      </b-col>

      <b-col cols="12" md="3" xl="3">
        <b-card>
          <!-- Button: Print -->
          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="primary" class="mb-75" block>
            Print Data
          </b-button>

          <hr />

          <!-- Button: Delete -->
          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="outline-secondary" class="mb-75" block>
            Delete
          </b-button>
        </b-card>
      </b-col>
    </b-row>
  </section>
</template>

<script>
import { ref } from '@vue/composition-api'
import { BFormGroup, BFormInput, BFormTextarea, BButton, BCol, BRow, BCard, BTable } from 'bootstrap-vue'

import Ripple from 'vue-ripple-directive'

export default {
  components: {
    BFormGroup,
    BFormInput,
    BFormTextarea,
    BButton,
    BCol,
    BRow,
    BCard,
    BTable,
  },
  directives: {
    Ripple,
  },
  computed: {
    tanggal() {
      return this.$moment(this.detailTransfer.created_at).format('DD MMMM YYYY')
    },
  },
  mounted() {
    this.loadData()
  },
  methods: {
    loadData() {
      const { id } = this.$router.currentRoute.params
      if (this.$store.getters['app-persediaan/getListDataTransfer'].length === 0) {
        const user = JSON.parse(localStorage.getItem('userData'))
        this.$store
          .dispatch('app-persediaan/fetchListDataTransfer', {
            cabang: user.cabang_id,
          })
          .then(res => {
            this.$store.commit('app-persediaan/SET_LIST_DATA_TRANSFER', res.data)
          })
      }
      this.detailTransfer = this.$store.getters['app-persediaan/getListDataTransfer'].find(x => x.id === id)
      console.info(this.detailTransfer)
    },
  },
  setup() {
    const detailTransfer = ref([])

    const tableColumns = [
      { key: 'nama', label: 'Kode / Nama Barang', sortable: false },
      { key: 'jumlah', sortable: false },
    ]
    return {
      detailTransfer,
      tableColumns,
    }
  },
}
</script>
