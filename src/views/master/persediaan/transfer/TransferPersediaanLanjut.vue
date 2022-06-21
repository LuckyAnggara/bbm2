<template>
  <section>
    <b-row class="match-height" ref="formContainer">
      <b-col cols="12" lg="4" xl="4">
        <b-card :title="`Data Gudang`">
          <b-form-group label="Dari Gudang" label-for="dari">
            <b-form-input v-model="data.dataGudang.dari.nama" type="text" readonly />
          </b-form-group>
          <b-form-group label="Ke Gudang" label-for="ke">
            <b-form-input v-model="data.dataGudang.ke.nama" type="text" readonly />
          </b-form-group>
          <b-form-group label="Tanggal Transfer" label-for="tanggalTransfer">
            <b-form-datepicker id="tanggalTransfer" v-model="data.tanggalTransaksi" readonly />
          </b-form-group>
          <b-form-group label="Catatan" label-for="catatan">
            <b-form-textarea placeholder="Catatan" v-model="data.catatan" type="text" readonly />
          </b-form-group>
        </b-card>
      </b-col>
      <b-col lg="8" cols="12">
        <b-card :title="`Data Persediaan yang akan di Transfer`">
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
                  :options="dataPersediaan"
                >
                  <template v-slot:option="option">
                    {{ option.kode_barang }} - <b>{{ option.nama }}</b> - {{ option.persediaan.saldo }}
                  </template>
                </v-select>
                <b-button variant="primary" @click="tambah" :disabled="idBarang == '' ? true : false">
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

            <template #cell(saldo)="data">
              <span>
                {{ data.item.saldo }}
              </span>
            </template>

            <template #cell(transfer)="data">
              <span>
                <b-form-input :max="data.item.saldo" type="number" v-model="data.item.transfer" />
              </span>
            </template>

            <template #cell(sisa)="data">
              <span>
                <feather-icon :icon="data.item.sisa < 0 ? 'ChevronsDownIcon' : 'ChevronsUpIcon'" :class="data.item.sisa < 0 ? 'text-danger' : 'text-success'" />
                {{ sisa(data) }}
              </span>
            </template>

            <!-- Column: Actions -->
            <template #cell(action)="data">
              <div class="text-nowrap">
                <feather-icon icon="TrashIcon" size="16" class="mx-1 text-danger" @click="del(data.index)" />
              </div>
            </template>
          </b-table>

          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="primary" class="mt-2 mr-1" @click="proses">
            Proses
          </b-button>
        </b-card>
      </b-col>
    </b-row>
  </section>
</template>

<script>
import store from '@/store'
import { ref } from '@vue/composition-api'
import { BCol, BRow, BCard, BTable, BButton, BFormInput, BFormGroup, BFormTextarea, BFormDatepicker } from 'bootstrap-vue'
import vSelect from 'vue-select'

import Ripple from 'vue-ripple-directive'

export default {
  components: {
    BFormDatepicker,
    BCol,
    BRow,
    BCard,
    BTable,
    vSelect,
    BButton,
    BFormInput,
    BFormGroup,
    BFormTextarea,
  },
  directives: {
    Ripple,
  },
  computed: {
    data() {
      return this.$router.currentRoute.params
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
        name: 'master-persediaan-transfer',
      })
    },
    errorProses() {
      this.$swal({
        title: 'Error!',
        text: 'Tidak ada Persediaan yang akan di Transfer',
        icon: 'error',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
    },
    error(data) {
      this.$swal({
        title: 'Error!',
        text: `Data barang ${data.nama} sudah ada`,
        icon: 'error',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
    },
    cek(id) {
      const a = this.persediaan.find(x => x.id === id)
      if (a === undefined) {
        return false
      }
      return true
    },
    del(index) {
      this.persediaan.splice(index, 1)
    },
    tambah() {
      const data = this.$store.getters['app-persediaan/getListPersediaan'].find(x => x.id === this.idBarang)
      if (this.cek(this.idBarang)) {
        this.error(data)
        return
      }
      const output = {
        id: data.id,
        id_barang: data.id,
        kode_barang: data.kode_barang,
        nama: data.nama,
        saldo: data.persediaan.saldo,
        transfer: 0,
      }
      this.persediaan.push(output)
      this.idBarang = ''
    },
    /* eslint-disable no-param-reassign */
    sisa(data) {
      data.item.sisa = parseFloat(data.item.saldo) - parseFloat(data.item.transfer)
      return data.item.sisa
    },
    /* eslint-enable no-param-reassign */
    loadDataBarang() {
      const user = JSON.parse(localStorage.getItem('userData'))
      const cabang = user.cabang_id
      const gudang = this.data.dataGudang.dari.id
      store
        .dispatch('app-persediaan/fetchListPersediaan', {
          cabang,
          gudang,
        })
        .then(res => {
          store.commit('app-persediaan/SET_LIST_PERSEDIAAN', res.data)
          this.dataPersediaan = store.getters['app-persediaan/getListPersediaan'].filter(
            x => x.persediaan.saldo !== 0 || x.persediaan.saldo_masuk !== 0 || x.persediaan.saldo_keluar !== 0,
          )
        })
    },
    proses() {
      if (this.persediaan.length === 0) {
        this.errorProses('c')
        return false
      }

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
            .dispatch('app-persediaan/storeTransferPersediaan', {
              data: this.data,
              persediaan: this.persediaan,
              gudang: this.dataGudang,
              user,
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
      return true
    },
  },
  mounted() {
    this.loadDataBarang()
  },
  setup() {
    const persediaan = ref([])

    const dataPersediaan = ref([])

    const barang = ref([])
    const idBarang = ref()
    const tableColumns = [
      { label: 'Nama / Kode Barang', key: 'nama', sortable: false },
      { key: 'saldo', label: 'saldo (qty)', sortable: false },
      { key: 'transfer', label: 'transfer (qty)', sortable: false },
      { key: 'sisa', label: 'sisa (qty)', sortable: false },
      { key: 'action', sortable: false },
    ]
    return {
      persediaan,
      dataPersediaan,
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
