<template>
  <section>
    <b-row class="match-height">
      <b-col lg="12" cols="12">
        <b-card>
          <h4>
            Nomor Jurnal
            <u
              ><b>{{ nomorJurnal }}</b></u
            >
          </h4>
          <hr />
          <b-form-group label="Tanggal Transaksi" label-for="tanggalTransaksi" label-cols-md="4">
            <flat-pickr disabled v-model="tanggalTransaksi.value" class="form-control" :config="tanggalTransaksi.config" placeholder="Tanggal Transaksi" />
          </b-form-group>
          <div class="mt-2">
            <b-table
              responsive
              primary-key="id"
              :fields="tableColumns"
              show-empty
              empty-text="Tidak ada data"
              :items="dataJurnal"
              class="position-relative"
              foot-clone
            >
              <!-- Column: Id -->
              <template #cell(id)="data">
                <span>
                  {{ data.index + 1 }}
                </span>
              </template>
              <template #cell(kode_akun)="data">
                <b-link :to="{ name: 'akuntansi-ledger-detail', params: { id: data.item.master_akun_id } }" class="font-weight-bold">
                  {{ data.item.kode_akun }}
                </b-link>
              </template>
              <template #cell(nama_akun)="data">
                <b-link :to="{ name: 'akuntansi-ledger-detail', params: { id: data.item.master_akun_id } }" class="font-weight-bold">
                  {{ data.item.nama_akun }}
                </b-link>
              </template>

              <template #cell(debit)="data">
                <span class="text-nowrap">
                  {{ data.item.jenis === 'DEBIT' ? formatRupiah(data.item.nominal) : formatRupiah(0) }}
                </span>
              </template>
              <template #cell(kredit)="data">
                <span class="text-nowrap">
                  {{ data.item.jenis === 'KREDIT' ? formatRupiah(data.item.nominal) : formatRupiah(0) }}
                </span>
              </template>

              <!-- FOOTER -->

              <!-- Debit -->
              <template #foot(namaAkun)>
                <span>Total</span>
              </template>
              <template #foot(debit)>
                <span class="text-success">{{ formatRupiah(totalDebit) }}</span>
              </template>
              <template #foot(kredit)>
                <span class="text-danger">{{ formatRupiah(totalKredit) }}</span>
              </template>
              <template #foot(keterangan)>
                <span class="text-primary">{{ balance }}</span>
              </template>
            </b-table>
          </div>
        </b-card>
      </b-col>
    </b-row>
  </section>
</template>

<script>
import router from '@/router'
import store from '@/store'
import { ref } from '@vue/composition-api'

import { BCard, BLink, BFormGroup, BRow, BCol, BTable } from 'bootstrap-vue'
import Ripple from 'vue-ripple-directive'
import flatPickr from 'vue-flatpickr-component'

export default {
  components: {
    flatPickr,
    BTable,
    BLink,
    BCard,
    BRow,
    BCol,
    BFormGroup,
  },
  directives: {
    Ripple,
  },
  data() {
    return {
      tanggalTransaksi: {
        value: Date.now(),
        config: {
          wrap: true, // set wrap to true only when using 'input-group'
          altFormat: 'd F Y',
          altInput: true,
          dateFormat: 'Y-m-d',
        },
      },
      jenis: '',
      saldo: 0,
      akun: '',
      catatan: '',
    }
  },
  mounted() {
    this.loadAkun()
  },
  computed: {
    nomorJurnal() {
      const { id } = router.currentRoute.params
      return id
    },
    totalDebit() {
      let saldoDebit = 0
      this.dataJurnal.forEach(x => {
        if (x.jenis === 'DEBIT') {
          saldoDebit += parseFloat(x.nominal)
        }
      })
      return saldoDebit
    },
    totalKredit() {
      let saldoKredit = 0
      this.dataJurnal.forEach(x => {
        if (x.jenis === 'KREDIT') {
          saldoKredit += parseFloat(x.nominal)
        }
      })
      return saldoKredit
    },
    balance() {
      if (this.totalKredit === this.totalDebit) {
        return 'BALANCE'
      }
      return 'TIDAK BALANCE'
    },
  },
  methods: {
    success() {
      this.$swal({
        title: 'Success!',
        text: 'Jurnal berhasil di buat!!',
        icon: 'success',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
    },
    error() {
      this.$swal({
        title: 'Error!',
        text: 'Oopss ada masalah !!',
        icon: 'error',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
    },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
    cek() {
      if (this.jenis === '' || this.saldo === 0 || this.saldo === '' || this.akun === '') {
        return false
      }
      return true
    },
    clear() {
      this.jenis = ''
      this.akun = ''
      this.saldo = 0
    },
    remove(x) {
      this.dataJurnal.splice(x, 1)
      this.total()
    },
    loadAkun() {
      const nomorJurnal = router.currentRoute.params.id
      const data = store.getters['app-keuangan/getListJurnal']
      if (data.length > 0) {
        this.dataJurnal = data.filter(x => x.nomor_jurnal === nomorJurnal)
      } else {
        store
          .dispatch(
            'app-keuangan/fetchListNomorJurnal',
            nomorJurnal, // Nomor Jurnal bukan ID ya. ini mah cmn tulisannya aja
          )
          .then(res => {
            this.dataJurnal = res.data
          })
      }
    },
  },
  setup() {
    const tableColumns = [
      { label: 'No', key: 'id', sortable: false },
      { key: 'kode_akun', sortable: false },
      { key: 'nama_akun', sortable: false },
      { key: 'debit', sortable: false },
      { key: 'kredit', sortable: false },
      { label: 'catatan', key: 'keterangan', sortable: false },
    ]
    const dataAkun = ref([])
    const dataJurnal = ref([])
    const debitKredit = [
      {
        title: 'DEBIT',
        value: 0,
      },
      {
        title: 'KREDIT',
        value: 1,
      },
    ]
    return {
      dataJurnal,
      tableColumns,
      debitKredit,
      dataAkun,
    }
  },
}
</script>

<style lang="scss" scoped>
.per-page-selector {
  width: 90px;
}
</style>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
@import '@core/scss/vue/libs/vue-flatpicker.scss';
</style>
