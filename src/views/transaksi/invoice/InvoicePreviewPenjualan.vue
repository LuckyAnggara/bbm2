<template>
  <section class="invoice-preview-wrapper">
    <!-- Alert: No item found -->
    <b-alert variant="danger" v-if="dataInvoice === undefined ? true : false">
      <h4 class="alert-heading">
        Error fetching invoice data
      </h4>
      <div class="alert-body">
        Tidak ada Invoice di temukan, silahkan pilih kembali Invoice di
        <b-link class="alert-link" :to="{ name: 'transaksi-penjualan-daftar' }">
          <span class="text-primary">Daftar Transaksi</span>
        </b-link>
        untuk Invoice lainnya.
      </div>
    </b-alert>

    <b-row v-if="dataInvoice === undefined ? false : true" class="invoice-preview">
      <!-- Col: Left (Invoice Container) -->
      <b-col cols="12" xl="9" md="9">
        <b-card no-body class="invoice-preview-card">
          <!-- Header -->
          <b-card-body class="invoice-padding pb-0">
            <div class="d-flex justify-content-between flex-md-row flex-column invoice-spacing mt-0">
              <!-- Header: Left Content -->
              <div>
                <div class="logo-wrapper">
                  <logo />
                  <h3 class="text-primary invoice-logo">PT. Berkah Baja Makmur</h3>
                </div>
                <p class="card-text mb-25">Cabang {{ dataUser.cabang.nama }}</p>
                <p class="card-text mb-25">
                  {{ dataUser.cabang.alamat }}
                </p>
                <p class="card-text mb-25">Nomor Telepon : {{ dataUser.cabang.nomor_telepon }}</p>
                <h3 v-if="typeRetur" class="text-danger">STATUS RETUR</h3>
              </div>

              <!-- Header: Right Content -->
              <div class="mt-md-0 mt-1">
                <h6 class="invoice-title">
                  Invoice
                  <span class="invoice-number">#{{ dataInvoice.nomorTransaksi }}</span>
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
                      <!-- <tr v-show="dataInvoice.pembayaran.sisaPembayaran === 0 ? false : true">
                        <td class="pr-1">
                          Down Payment:
                        </td>
                        <td>
                          {{ formatRupiah(dataInvoice.pembayaran.downPayment) }}
                        </td>
                      </tr> -->
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
          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="primary" class="mb-75" block>
            Print Invoice
          </b-button>

          <!-- Button: Download -->
          <b-button v-ripple.400="'rgba(186, 191, 199, 0.15)'" variant="outline-secondary" class="mb-75" block>
            Download
          </b-button>

          <!-- Button: Jurnal -->
          <b-button
            :to="{ name: 'akuntansi-jurnal-detail', params: { id: dataInvoice.nomorJurnal } }"
            v-ripple.400="'rgba(186, 191, 199, 0.15)'"
            variant="outline-secondary"
            class="mb-75"
            block
          >
            Jurnal
          </b-button>
          <!-- Button:  Rincian Pembayaran -->
          <b-button v-ripple.400="'rgba(186, 191, 199, 0.15)'" variant="outline-secondary" class="mb-75" block @click="showModalPembayaran()">
            Rincian Pembayaran
          </b-button>
          <div v-if="!typeRetur">
            <hr />
            <!-- Button: Retur -->
            <b-button v-ripple.400="'rgba(186, 191, 199, 0.15)'" variant="outline-danger" class="mb-75" block @click="retur(dataInvoice)">
              Retur
            </b-button>

            <!-- Button: Retur -->
            <b-button v-ripple.400="'rgba(186, 191, 199, 0.15)'" variant="outline-danger" class="mb-75" block @click="destroy(dataInvoice)">
              Delete
            </b-button>

            <!-- Button: Edit -->
            <!-- <b-button
              v-ripple.400="'rgba(186, 191, 199, 0.15)'"
              variant="outline-danger"
              class="mb-75"
              block
              :to="{ name: 'transaksi-penjualan-edit', params: { id: dataInvoice.id } }"
            >
              Edit
            </b-button> -->
            <hr />
          </div>

          <!-- Button: Add Payment -->
          <b-button
            v-show="dataInvoice.pembayaran.sisaPembayaran === 0 ? false : true"
            v-if="!typeRetur"
            v-ripple.400="'rgba(255, 255, 255, 0.15)'"
            variant="success"
            class="mb-75"
            block
            @click="showModal()"
          >
            Tambah Pembayaran
          </b-button>
        </b-card>
      </b-col>

      <modal-pembayaran :data-piutang="dataInvoice" />
      <modal-daftar-pembayaran />
    </b-row>
  </section>
</template>

<script>
import router from '@/router'

import { ref } from '@vue/composition-api'

import { BRow, BCol, BCard, BCardBody, BTableLite, BCardText, BButton, BAlert, BLink, VBToggle } from 'bootstrap-vue'
import Logo from '@core/layouts/components/Logo.vue'
import Ripple from 'vue-ripple-directive'
import store from '@/store'

import ModalPembayaran from './component/ModalPembayaranPiutang.vue'
import ModalDaftarPembayaran from './component/ModalDaftarPembayaranPenjualan.vue'

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
    BAlert,
    BLink,

    Logo,
    ModalPembayaran,
    ModalDaftarPembayaran,
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
          const loader = this.$loading.show({
            // Optional parameters
            container: this.$refs.formContainer,
          })
          store
            .dispatch('app-transaksi-penjualan/returTransaksi', {
              id,
            })
            .then(x => {
              loader.hide()
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
    destroy(data) {
      const { id } = data
      this.$swal({
        title: 'Delete data ?',
        text: 'Data penjualan akan di hapus',
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
          store
            .dispatch('app-transaksi-penjualan/deleteTransaksi', {
              id,
            })
            .then(x => {
              loader.hide()
              if (x.status === 200) {
                store.commit('app-transaksi-penjualan/REMOVE_DATA_PENJUALAN', id)
                this.$swal({
                  icon: 'success',
                  title: 'Transaksi berhasil di Delete!',
                  customClass: {
                    confirmButton: 'btn btn-success',
                  },
                })
                router.push({
                  name: 'transaksi-penjualan-daftar',
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
    showModal() {
      this.$bvModal.show('modal-pembayaran-piutang')
    },
    showModalPembayaran() {
      this.$bvModal.show('modal-daftar-pembayaran-penjualan')
    },
  },
  mounted() {
    const { id } = router.currentRoute.params
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
    const dataUser = JSON.parse(localStorage.getItem('userData'))
    return {
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
