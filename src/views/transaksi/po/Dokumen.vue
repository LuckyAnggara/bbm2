<template>
  <section class="invoice-preview-wrapper">
    <b-row v-if="dataPO" class="invoice-preview">
      <!-- Col: Left (Invoice Container) -->
      <b-col cols="12" xl="9" md="8">
        <b-card no-body class="invoice-preview-card">
          <!-- Header -->
          <b-card-body class="invoice-padding pb-0">
            <div class="d-flex justify-content-between flex-md-row flex-column invoice-spacing mt-0">
              <!-- Header: Left Content -->
              <div>
                <div class="logo-wrapper">
                  <h3 class="text-primary invoice-logo">PURCHASE ORDER</h3>
                </div>
              </div>
              <!-- Header: Right Content -->
              <div class="mt-md-0 mt-1">
                <h6 class="mb-25">
                  Nomor :
                  <span>{{ dataPO.kode_po }}</span>
                </h6>
                <h6 class="mb-25">
                  Tanggal :
                  <span>{{ this.$moment(dataPO.created_at).format('DD MMMM YYYY') }}</span>
                </h6>
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
                <h6 class="mb-25">
                  Kepada Yth :
                </h6>
                <h6 class="mb-25">
                  Kepala Cabang
                </h6>
                <h6 class="mb-25">
                  {{ dataPO.cabang_tujuan.nama.toUpperCase() }}
                </h6>
                di
                <p class="card-text mb-25">
                  <span> - Tempat</span>
                </p>
              </b-col>

              <!-- Col: Payment Details -->
              <b-col xl="6" cols="12" class="p-0 mt-xl-0 mt-2 d-flex justify-content-xl-end">
                <div>
                  <h6>
                    Dari :
                  </h6>
                  <table>
                    <tbody>
                      <tr>
                        <td>
                          <h6 class="mb-25">
                            Cabang
                          </h6>
                        </td>
                      </tr>
                      <tr>
                        <td>
                          <h6 class="mb-25">
                            {{ dataPO.user.cabang.nama.toUpperCase() }}
                          </h6>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </b-col>
            </b-row>
          </b-card-body>

          <!-- Invoice Description: Table -->
          <b-table-lite class="font-weight-bold mb-25" small responsive :items="dataPO.detail" :fields="['no', 'kode_barang', 'nama_barang', 'jumlah']">
            <template #cell(no)="data">{{ data.index + 1 }}</template>
          </b-table-lite>

          <!-- Invoice Description: Total -->
          <b-card-body class="invoice-padding pb-0">
            <b-row class="invoice-spacing">
              <!-- Col: Sales Persion -->
              <b-col cols="12" xl="9" class="p-0"> </b-col>

              <!-- Col: Total -->
              <b-col xl="3" cols="12" class="p-0 justify-content-xl-end">
                <table>
                  <tbody>
                    <tr>
                      <td>
                        <span class="font-weight-bold"> {{ this.$moment(dataPO.created_at).format('DD MMMM YYYY') }}</span>
                      </td>
                    </tr>
                  </tbody>
                </table>
                <br />
                <br />
                <br />
                <span class="font-weight-bold">Kepala Cabang</span>
              </b-col>
            </b-row>
          </b-card-body>

          <!-- Spacer -->
          <hr class="invoice-spacing" />

          <!-- Note -->
          <b-card-body class="invoice-padding pt-0">
            <span class="font-weight-bold"
              ><u>
                <b>Catatan:</b>
              </u>
              <br />{{ dataPO.catatan }}
            </span>
            <span>..</span>
          </b-card-body>
        </b-card>
      </b-col>
      <!-- Right Col: Card -->
      <b-col cols="12" md="3" xl="3" class="invoice-actions" v-show="dataPO.cabang_tujuan.id != dataUser.cabang_id">
        <b-card>
          <!-- Button: Send Invoice -->
          <span class="mb-5"
            >Status :
            <b-badge pill variant="light-warning" v-if="dataPO.status === 'SEND'">
              {{ dataPO.status }}
            </b-badge>
            <b-badge pill variant="light-success" v-if="dataPO.status === 'APPROVED'">
              {{ dataPO.status }}
            </b-badge>
            <b-badge pill variant="light-success" v-if="dataPO.status === 'SELESAI'">
              {{ dataPO.status }}
            </b-badge>
            <b-badge pill variant="light-danger" v-if="dataPO.status === 'REJECT'">
              {{ dataPO.status }}
            </b-badge>
          </span>
          <hr />

          <!-- Button: Send Invoice -->
          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="primary" class="mb-75" block @click="printInvoice">
            Print
          </b-button>
          <!-- Button: Send Invoice -->
          <!-- <b-button
            v-ripple.400="'rgba(255, 255, 255, 0.15)'"
            variant="outline-primary"
            class="mb-75"
            @click="showModal(dataPO)"
            block
            v-if="dataPO.status_po_masuk === 'DITERIMA'"
          >
            Terima
          </b-button> -->

          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="warning" class="mb-75" block v-if="dataPO.status === 'SEND'" @click="batal(dataPO.id)">
            Batalkan
          </b-button>
        </b-card>
      </b-col>

      <!-- Right Col: Card -->
      <b-col cols="12" md="3" xl="3" class="invoice-actions" v-show="dataPO.cabang_tujuan.id === dataUser.cabang_id">
        <b-card>
          <span class="mb-5"
            >Status :
            <b-badge pill variant="light-warning" v-if="dataPO.status === 'SEND'">
              {{ dataPO.status }}
            </b-badge>
            <b-badge pill variant="light-success" v-if="dataPO.status === 'APPROVED'">
              {{ dataPO.status }}
            </b-badge>
            <b-badge pill variant="light-danger" v-if="dataPO.status === 'REJECT'">
              {{ dataPO.status }}
            </b-badge>
          </span>
          <hr />
          <!-- Button: Send Invoice -->
          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="primary" class="mb-75" block @click="printInvoice">
            Print
          </b-button>

          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="success" class="mb-75" block v-if="dataPO.status === 'SEND'" @click="proses(dataPO)">
            Proses
          </b-button>
          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="danger" class="mb-75" block v-if="dataPO.status === 'SEND'" @click="tolak(dataPO.id)">
            Tolak
          </b-button>
        </b-card>
      </b-col>
    </b-row>
    <terima-modal :data="dataIndividualPO" :id="dataId" />
  </section>
</template>

<script>
import router from '@/router'

import { ref } from '@vue/composition-api'

import { BBadge, BRow, BCol, BCard, BCardBody, BTableLite, BButton } from 'bootstrap-vue'
import Ripple from 'vue-ripple-directive'
import TerimaModal from './component/TerimaModal.vue'

export default {
  directives: {
    Ripple,
  },
  components: {
    BBadge,
    BRow,
    BCol,
    BCard,
    BCardBody,
    BTableLite,
    BButton,
    TerimaModal,
    // Logo,
  },
  data() {
    return {
      dibatalkan: false,
      dataIndividualPO: null,
      dataId: null,
    }
  },

  methods: {
    showModal(x) {
      this.dataIndividualPO = x
      this.dataId = x.id
      this.$bvModal.show('modal-terima')
    },
    print() {},
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
    batal(id) {
      this.$swal({
        title: 'Batalkan P.O ?',
        text: 'P.O ini akan di batalkan',
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
          this.$store
            .dispatch('app-po/batalPO', {
              id,
            })
            .then(res => {
              if (res.status === 200) {
                this.$swal({
                  icon: 'success',
                  title: 'P.O Dibatalkan!',
                  customClass: {
                    confirmButton: 'btn btn-success',
                  },
                })
                this.$store.commit('app-po/BATAL_PO', id)
              }
            })
        }
      })
    },
    del(id) {
      this.$swal({
        title: 'Delete P.O ?',
        text: 'P.O ini akan di Hapus!',
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
          this.$store
            .dispatch('app-po/deletePO', {
              id,
            })
            .then(res => {
              if (res.status === 200) {
                this.$swal({
                  icon: 'success',
                  title: 'Deleted!',
                  customClass: {
                    confirmButton: 'btn btn-success',
                  },
                })
                this.$store.commit('app-po/REMOVE_PO', id)
                this.$router.push({
                  name: 'transaksi-po-daftar',
                })
              }
            })
            .catch(error => {
              this.error(`${error} Data sudah di hapus`)
            })
        }
      })
    },
    proses(dataPO) {
      this.$swal({
        title: 'Proses ?',
        text: 'P.O ini akan di Reviu sebelum di Proses',
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
          // this.$store.dispatch('app-po/prosesPO', {
          //   id: dataPO.id,
          // })
          this.$router.push({
            name: 'transaksi-po-proses',
            params: {
              data: dataPO,
            },
          })
        }
      })
    },
    tolak(id) {
      this.$swal({
        title: 'Tolak ?',
        text: 'P.O ini akan di tolak',
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
          this.$store.dispatch('app-po/tolakPO', {
            id,
          })
        }
      })
    },
  },
  created() {
    const { data } = router.currentRoute.params
    this.dataPO = data
    if (this.dataPO.status_po_masuk === 'BELUM DIBACA') {
      if (this.dataUser.cabang_id === this.dataPO.cabang_tujuan.id) {
        this.$store.dispatch('app-po/updateStatus', {
          id: this.dataPO.id,
          status: 'DIBACA',
        })
      }
    }
  },
  setup() {
    const dataPO = ref({})
    const dataUser = JSON.parse(localStorage.getItem('userData'))

    const printInvoice = () => {
      window.print()
    }
    return {
      dataUser,
      dataPO,
      printInvoice,
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
