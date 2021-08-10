<template>
  <section>
    <b-row class="match-height">
      <b-col lg="12" cols="12">
        <b-card :title="`Penyesuaian Stok Tanggal : ${tanggal}`">
          <div class="mb-2">
            <!-- Table Top -->
            <b-row>
              <!-- Per Page -->
              <b-col cols="12" md="12" class="d-flex align-items-center justify-content-start mb-1 mb-md-0">
                <label>Kode / Nama Barang </label>
                <v-select
                  v-model="idBarang"
                  class="barang-selector d-inline-block ml-50 mr-1"
                  placeholder="Nama / Kode Barang"
                  label="nama"
                  :reduce="barang => barang.id"
                  :options="barang"
                >
                  <template v-slot:option="option">
                    {{ option.kode_barang }} - <b>{{ option.nama }}</b>
                  </template>
                </v-select>
                <b-button variant="primary" @click="tambah">
                  Tambah
                </b-button>
              </b-col>
            </b-row>
          </div>

          <b-table show-empty empty-text="Tidak ada data" class="position-relative" :items="persediaan" :fields="tableColumns">
            <!-- Column: Nama -->
            <template #cell(nama)="data">
              <span>
                {{ `${data.item.kode_barang} - ${data.item.nama}` }}
              </span>
            </template>

            <template #cell(jumlah_fisik)="data">
              <span>
                <feather-icon
                  :icon="data.item.jumlah_fisik < 0 ? 'ChevronsDownIcon' : 'ChevronsUpIcon'"
                  :class="data.item.jumlah_fisik < 0 ? 'text-danger' : 'text-success'"
                />
                {{ jumlahFisik(data) }}
              </span>
            </template>

            <template #cell(perbedaan)="data">
              <span>
                <b-form-input type="number" v-model="data.item.perbedaan" />
              </span>
            </template>

            <template #cell(harga)="data">
              <span>
                <b-form-input type="number" v-model="data.item.harga" :disabled="data.item.perbedaan > 0 ? false : true" />
              </span>
            </template>

            <!-- Column: Actions -->
            <template #cell(action)="data">
              <div class="text-nowrap">
                <feather-icon icon="TrashIcon" size="16" class="mx-1 text-danger" @click="del(data.index)" />
              </div>
            </template>
          </b-table>
          <hr />
          <div class="mt-2">
            <!-- Table Top -->
            <b-row>
              <!-- Per Page -->
              <b-col cols="12" md="12" class="d-flex align-items-center justify-content-start mb-1 mb-md-0">
                <b-button
                  v-show="persediaan.length > 0"
                  v-ripple.400="'rgba(255, 255, 255, 0.15)'"
                  type="submit"
                  variant="primary"
                  class="mr-1"
                  @click="proses"
                >
                  Proses
                </b-button>
              </b-col>
            </b-row>
          </div>
        </b-card>
      </b-col>
    </b-row>
  </section>
</template>

<script>
import { ref } from '@vue/composition-api'
import { BCol, BRow, BCard, BTable, BButton, BFormInput } from 'bootstrap-vue'
import vSelect from 'vue-select'

import Ripple from 'vue-ripple-directive'

export default {
  components: {
    BCol,
    BRow,
    BCard,
    BTable,
    vSelect,
    BButton,
    BFormInput,
  },
  directives: {
    Ripple,
  },
  computed: {
    data() {
      return this.$router.currentRoute.params
    },
    tanggal() {
      return this.$moment(this.data.tanggalTransaksi.value).format('DD/MM/YYYY')
    },
    tanggalFormated() {
      return this.$moment(this.data.tanggalTransaksi.value).format('YYYY-MM-DD')
    },
  },
  methods: {
    success() {
      this.$swal({
        title: 'Success!',
        text: 'Transaksi Sukses!!',
        icon: 'success',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })

      this.$router.push({
        name: 'master-persediaan',
      })
    },
    error(error) {
      this.$swal({
        title: 'Error!',
        text: `Oopss ada Masalah!${error}`,
        icon: 'error',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
    },
    proses() {
      const user = JSON.parse(localStorage.getItem('userData'))

      this.$swal({
        title: 'Proses ?',
        text: 'Data akan di proses',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Proses !!',
        customClass: {
          confirmButton: 'btn btn-primary',
          cancelButton: 'btn btn-outline-danger ml-1',
        },
        buttonsStyling: false,
      }).then(result => {
        if (result.value) {
          const loader = this.$loading.show({
            container: this.$refs.formContainer,
          })
          this.$store
            .dispatch('app-persediaan/storePenyesuaianPersediaan', {
              user,
              gudang: this.data.gudang,
              data: this.persediaan,
              jumlah_data: this.persediaan.length,
              tipe: this.data.tipe,
              kategori: this.data.kategori,
              catatan: this.data.catatan,
              tanggalTransaksi: this.tanggalFormated,
            })
            .then(res => {
              if (res.status === 200) {
                this.success()
              } else {
                this.error()
              }
              loader.hide()
            })
        }
      })
    },
    del(index) {
      this.persediaan.splice(index, 1)
    },
    /* eslint-disable no-param-reassign */
    jumlahFisik(data) {
      data.item.jumlah_fisik = parseFloat(data.item.jumlah_tercatat) + parseFloat(data.item.perbedaan)
      data.item.jenis = data.item.perbedaan < 0 ? 'KREDIT' : 'DEBIT'
      return data.item.jumlah_fisik
    },
    /* eslint-enable no-param-reassign */
    loadData() {
      const user = JSON.parse(localStorage.getItem('userData'))
      const cabang = user.cabang_id
      const gudang = this.data.gudang.id
      if (this.$store.getters['app-barang/getListBarang'].length === 0) {
        this.$store.dispatch('app-barang/fetchListBarang').then(res => {
          this.$store.commit('app-barang/SET_LIST_BARANG', res.data)
          const data = this.$store.getters['app-barang/getListBarang']
          this.barang = data
          return data
        })
      }

      if (this.$store.getters['app-persediaan/getListPersediaan'].length === 0) {
        this.$store
          .dispatch('app-persediaan/fetchListPersediaan', {
            cabang,
            gudang,
          })
          .then(res => {
            this.$store.commit('app-persediaan/SET_LIST_PERSEDIAAN', res.data)
          })
      }
      this.barang = this.$store.getters['app-barang/getListBarang']
      return this.$store.getters['app-barang/getListBarang']
    },
    tambah() {
      const a = this.persediaan.find(x => x.id === this.idBarang)
      if (a === undefined) {
        const data = this.$store.getters['app-persediaan/getListPersediaan'].find(x => x.id === this.idBarang)
        const output = {
          id: data.id,
          kode_barang: data.kode_barang,
          nama: data.nama,
          jumlah_tercatat: data.persediaan.saldo,
          jumlah_fisik: 0,
          harga: 0,
          tanggalTransaksi: this.tanggalFormated,
        }
        output.perbedaan = parseFloat(output.jumlah_tercatat) - parseFloat(output.jumlah_tercatat)
        output.jenis = output.perbedaan < 0 ? 'KREDIT' : 'DEBIT'
        this.persediaan.push(output)
      } else {
        this.$swal({
          title: 'Error!',
          text: 'Barang sudah ada!',
          icon: 'error',
          customClass: {
            confirmButton: 'btn btn-primary',
          },
          buttonsStyling: false,
        })
      }
    },
  },
  mounted() {
    this.loadData()
  },
  setup() {
    const persediaan = ref([])

    const barang = ref([])
    const idBarang = ref()
    const tableColumns = [
      { label: 'Nama / Kode Barang', key: 'nama', sortable: false },
      { key: 'jumlah_tercatat', sortable: false },
      { key: 'jumlah_fisik', sortable: false },
      { key: 'perbedaan', sortable: false },
      { key: 'harga', sortable: false },
      { key: 'action', sortable: false },
    ]
    return {
      persediaan,
      barang,
      idBarang,
      tableColumns,
    }
  },
}
</script>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
.barang-selector {
  width: 400px;
  min-width: 190px;

  ::v-deep .vs__selected-options {
    flex-wrap: nowrap;
  }

  ::v-deep .vs__selected {
    width: 100px;
  }
}
</style>
