<template>
  <section class="invoice-preview-wrapper">
    <b-row v-if="dataInvoice === undefined ? false : true" class="invoice-preview">
      <!-- Col: Left (Invoice Container) -->
      <b-col cols="12" xl="9" md="9" ref="formContainer">
        <b-card no-body class="invoice-preview-card">
          <!-- Header -->
          <b-card-body class="invoice-padding pb-0">
            <div class="d-flex justify-content-between flex-md-row flex-column invoice-spacing mt-0">
              <!-- Header: Left Content -->
              <div>
                <div class="logo-wrapper">
                  <!-- <logo /> -->
                  <h3 class="text-primary invoice-logo">Invoice Purchase Order</h3>
                </div>
              </div>

              <!-- Header: Right Content -->
              <div class="mt-md-0 mt-1">
                <h6 class="invoice-title">
                  Invoice
                  <span class="invoice-number">#{{ dataInvoice.nomorTransaksi }}</span>
                </h6>
                <h6>
                  Kode P.O :
                  <span> {{ dataPO.kode_po }}</span>
                </h6>
                <div class="invoice-date-wrapper">
                  <table>
                    <tbody>
                      <tr>
                        <td class="pr-1">
                          Tanggal Terbit:
                        </td>
                        <td>
                          <span class="font-weight-bold"> {{ this.$moment(dataInvoice.tanggalTransaksi).format('DD MMMM YYYY') }}</span>
                        </td>
                      </tr>
                      <tr v-show="dataInvoice.pembayaran.statusPembayaran.value === '1' ? true : false">
                        <td class="pr-1">
                          Tanggal Tempo:
                        </td>
                        <td>
                          <span class="font-weight-bold"> {{ this.$moment(dataInvoice.pembayaran.tanggalJatuhTempo).format('DD MMMM YYYY') }}</span>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </b-card-body>

          <!-- Spacer -->
          <hr class="invoice-spacing" />

          <!-- Invoice Client & Payment Details -->
          <b-card-body class="invoice-padding pt-0">
            <b-row class="invoice-spacing">
              <!-- Col: Invoice To -->
              <b-col cols="12" xl="6" class="p-0">
                <h6 class="mb-1">
                  Invoice Ke:
                </h6>
                <h6 class="mb-25">
                  {{ dataInvoice.pelanggan.nama }}
                </h6>
                <p class="card-text mb-25">
                  <span style="white-space: pre-line;"> {{ dataInvoice.pelanggan.alamat }}</span>
                </p>

                <p class="card-text mb-25">
                  {{ dataInvoice.pelanggan.nomorTelepon }}
                </p>
              </b-col>
              <!-- Col: Payment Details -->
              <b-col xl="6" cols="12" class="p-0 mt-xl-0 mt-2 d-flex justify-content-xl-end">
                <div>
                  <h6 class="mb-1">
                    Detail Pembayaran:
                  </h6>
                  <table>
                    <tbody>
                      <tr>
                        <td class="pr-1">
                          Total Tagihan:
                        </td>
                        <td>
                          <span class="font-weight-bold"> {{ formatRupiah(dataInvoice.invoice.grandTotal) }}</span>
                        </td>
                      </tr>
                      <tr v-show="dataInvoice.pembayaran.downPayment > 0 ? true : false">
                        <td class="pr-1">
                          Down Payment:
                        </td>
                        <td>
                          <span class="font-weight-bold"> {{ formatRupiah(dataInvoice.pembayaran.downPayment) }}</span>
                        </td>
                      </tr>
                      <tr v-show="dataInvoice.pembayaran.statusPembayaran.value === '1' ? false : true">
                        <td class="pr-1">
                          Jenis Pembayaran:
                        </td>
                        <td>{{ dataInvoice.pembayaran.jenisPembayaran.title }}</td>
                      </tr>
                      <tr v-show="dataInvoice.pembayaran.bank === '' || dataInvoice.pembayaran.bank === null ? false : true">
                        <td class="pr-1">
                          Bank:
                        </td>
                        <td>{{ bank }}</td>
                      </tr>
                      <tr>
                        <td class="pr-1">
                          Status Pembayaran:
                        </td>
                        <td>
                          <b>{{ dataInvoice.pembayaran.sisaPembayaran === 0 ? 'Lunas' : 'Belum Lunas' }}</b>
                        </td>
                      </tr>
                      <tr v-show="dataInvoice.pembayaran.sisaPembayaran === 0 ? false : true">
                        <td class="pr-1">
                          Sisa Tagihan:
                        </td>
                        <td>
                          <b>{{ sisaTagihan }}</b>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </b-col>
            </b-row>
          </b-card-body>

          <!-- Invoice Description: Table -->
          <b-table-lite responsive :items="dataInvoice.orders" :fields="['nama_barang', 'harga', 'jumlah', 'total']">
            <template #cell(harga)="data">
              <span class="text-nowrap">
                {{ formatRupiah(data.value) }}
              </span>
            </template>
            <template #cell(total)="data">
              <span class="text-nowrap">
                {{ formatRupiah(data.value) }}
              </span>
            </template>
          </b-table-lite>

          <!-- Invoice Description: Total -->
          <b-card-body class="invoice-padding pb-0">
            <b-row class="invoice-spacing">
              <!-- Col: Sales Persion -->
              <b-col cols="12" xl="6" class="p-0">
                <b-card-text class="mb-0">
                  <span class="font-weight-bold">Kasir</span>
                </b-card-text>
                <br />
                <br />
                <br />
                <span class="font-weight-bold">{{ dataInvoice.user.nama_lengkap }}</span>
              </b-col>

              <!-- Col: Total -->
              <b-col xl="6" cols="12" class="p-0 mt-xl-0 mt-2 d-flex justify-content-xl-end">
                <table>
                  <tbody>
                    <tr>
                      <td class="pr-1">
                        Sub Total:
                      </td>
                      <td>
                        <span class="font-weight-bold">{{ formatRupiah(dataInvoice.invoice.total) }}</span>
                      </td>
                    </tr>
                    <tr>
                      <td class="pr-1 text-danger">
                        Diskon:
                      </td>
                      <td class="pr-1 text-danger">
                        {{ formatRupiah(dataInvoice.invoice.diskon) }}
                      </td>
                    </tr>
                    <tr>
                      <td class="pr-1">
                        Pajak:
                      </td>
                      <td>{{ formatRupiah(dataInvoice.invoice.pajak) }}</td>
                    </tr>
                    <tr>
                      <td class="pr-1">
                        Ongkos Kirim:
                      </td>
                      <td>
                        {{ formatRupiah(dataInvoice.invoice.ongkir) }}
                      </td>
                    </tr>
                    <hr />
                    <tr>
                      <td class="pr-1">
                        Total:
                      </td>
                      <td>
                        <b>{{ formatRupiah(dataInvoice.invoice.grandTotal) }}</b>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </b-col>
            </b-row>
          </b-card-body>

          <!-- Spacer -->
          <hr class="invoice-spacing" />

          <!-- Note -->
          <b-card-body class="invoice-padding pt-0">
            <span class="font-weight-bold"
              ><u>
                <b>Note:</b>
              </u>
              <br />{{ dataInvoice.catatan }}
            </span>
            <span>..</span>
          </b-card-body>
        </b-card>
      </b-col>
      <!-- Right Col: Card -->
      <b-col cols="12" md="3" xl="3" class="invoice-actions">
        <b-card>
          <!-- Button: Send Invoice -->
          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="primary" class="mb-75" block @click="selesai">
            Selesai
          </b-button>

          <!-- Button: Download -->
          <b-button v-ripple.400="'rgba(186, 191, 199, 0.15)'" variant="outline-secondary" class="mb-75" block>
            Retur
          </b-button>
        </b-card>
      </b-col>
    </b-row>
  </section>
</template>

<script>
import router from '@/router'

import { ref } from '@vue/composition-api'

import {
  BRow,
  BCol,
  BCard,
  BCardBody,
  BTableLite,
  BCardText,
  BButton,
  // BAlert,
  // BLink,
  VBToggle,
} from 'bootstrap-vue'
// import Logo from '@core/layouts/components/Logo.vue'
import Ripple from 'vue-ripple-directive'
import store from '@/store'

export default {
  directives: {
    Ripple,
    'b-toggle': VBToggle,
  },
  components: {
    BRow,
    BCol,
    BCard,
    BCardBody,
    BTableLite,
    BCardText,
    BButton,
    // BAlert,
    // BLink,

    // Logo,
  },
  data() {
    return {
      return: {
        transfer: false,
      },
      caraPembayaran: [
        { title: 'Tunai', value: '0' },
        { title: 'Transfer', value: '1' },
      ],
      piutang: {
        penjualan_id: '',
        tanggal: '',
        nominal: 0,
        caraPembayaran: '',
        catatan: '',
      },
    }
  },
  computed: {
    sisaTagihan() {
      return this.formatRupiah(this.dataInvoice.pembayaran.sisaPembayaran)
    },
    bank() {
      if (this.dataInvoice.pembayaran.bank === '' || this.dataInvoice.pembayaran.bank === null) {
        return ''
      }
      return `${this.dataInvoice.pembayaran.bank.nama_bank} - ${this.dataInvoice.pembayaran.bank.nomor_rekening}`
    },
    typeRetur() {
      if (this.dataInvoice.retur === 'Tidak') {
        return false
      }
      return true
    },
  },
  methods: {
    selesai() {
      const { id } = this.dataInvoice
      this.$swal({
        title: 'Selesai ?',
        text: 'Apakah Purchase Order telah sesuai ??',
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
          const loader = this.$loading.show({
            // Optional parameters
            container: this.$refs.formContainer,
          })
          store.dispatch('app-po/selesaiPO', { id, data_po: this.dataPO, data_invoice: this.dataInvoice, user: this.dataUser }).then(x => {
            loader.hide()
            if (x.status === 200) {
              this.$store.dispatch('app-po/updateStatus', {
                id,
                status: 'SELESAI',
              })
              this.$swal({
                icon: 'success',
                title: 'Transaksi selesai!',
                text: 'Silahkan cek Persediaan di Menu Persediaan',
                customClass: {
                  confirmButton: 'btn btn-success',
                },
              })
              this.$router.push({
                name: 'master-persediaan',
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
    cekTransfer() {
      if (this.dataInvoice.pembayaran.bank === '') {
        this.transfer = false
      }
      this.transfer = true
    },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
    printInvoice() {},
    retur(data) {
      const { id } = data
      this.$swal({
        title: 'Retur data ?',
        text: 'Data transaksi penjualan akan di retur',
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
            .dispatch('app-transaksi-penjualan/returTransaksi', {
              id,
            })
            .then(x => {
              if (x.status === 200) {
                store.commit('app-transaksi-penjualan/RETUR_DATA_PENJUALAN', id)
                this.$swal({
                  icon: 'success',
                  title: 'Transaksi sudah di Retur!',
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
  mounted() {
    const { id } = router.currentRoute.params
    const { data_po } = router.currentRoute.params
    // eslint-disable-next-line
    this.dataPO = data_po
    // eslint-enable-next-line
    if (id !== undefined) {
      store.dispatch('app-transaksi-penjualan/fetchTransaksi', id).then(res => {
        if (res.status === 200) {
          store.commit('app-transaksi-penjualan/SET_DATA_INVOICE', res.data)
          store.commit('app-transaksi-penjualan/SET_LIST_PEMBAYARAN', res.data.pembayaran.listPembayaran)
          this.dataInvoice = store.getters['app-transaksi-penjualan/getDataInvoice']
        }
      })
    }
  },
  setup() {
    const dataInvoice = ref()
    const dataPO = ref({
      kode_po: null,
    })
    const dataUser = JSON.parse(localStorage.getItem('userData'))
    return {
      dataPO,
      dataUser,
      dataInvoice,
    }
  },
}
</script>

<style lang="scss" scoped>
@import '@core/scss/vue/libs/vue-select.scss';
@import '~@core/scss/base/pages/app-invoice.scss';
</style>

<style lang="scss">
@media print {
  // Global Styles
  body {
    background-color: transparent !important;
  }
  nav.header-navbar {
    display: none;
  }
  .main-menu {
    display: none;
  }
  .header-navbar-shadow {
    display: none !important;
  }
  .content.app-content {
    margin-left: 0;
    padding-top: 1rem !important;
  }
  footer.footer {
    display: none;
  }
  .card {
    background-color: transparent;
    box-shadow: none;
  }
  .customizer-toggle {
    display: none !important;
  }

  // Invoice Specific Styles
  .invoice-preview-wrapper {
    .row.invoice-preview {
      .col-md-8 {
        max-width: 100%;
        flex-grow: 1;
      }

      .invoice-preview-card {
        .card-body:nth-of-type(2) {
          .row {
            > .col-12 {
              max-width: 50% !important;
            }

            .col-12:nth-child(2) {
              display: flex;
              align-items: flex-start;
              justify-content: flex-end;
              margin-top: 0 !important;
            }
          }
        }
      }
    }

    // Action Right Col
    .invoice-actions {
      display: none;
    }
  }
}
</style>
