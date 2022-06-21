<template>
  <section>
    <b-form>
      <b-col cols="12" class="mb-2">
        <h5 class="mb-0">
          Review Order
        </h5>
        <small class="text-muted">Cek kembali order sebelum ke Proses selanjutnya</small>
      </b-col>
      <b-row class="match-height">
        <b-col cols="12" md="6">
          <div class="checkout-options">
            <b-card>
              <div class="price-details">
                <h6 class="price-title">
                  Data Pelanggan
                </h6>
                <hr />
                <ul class="list-unstyled">
                  <li class="price-detail">
                    <div class="detail-title mb-1">
                      {{ dataOrder.pelanggan.nama }}
                    </div>
                  </li>
                  <li class="price-detail">
                    <div class="detail-title mb-1" style="white-space:pre-line;">
                      {{ dataOrder.pelanggan.alamat }}
                    </div>
                  </li>
                  <li class="price-detail">
                    <div class="detail-title">
                      {{ dataOrder.pelanggan.nomorTelepon }}
                    </div>
                  </li>
                </ul>
              </div>
            </b-card>
          </div>
        </b-col>
        <b-col cols="12" md="6">
          <div class="checkout-options">
            <b-card>
              <div class="price-details">
                <h6 class="price-title">
                  Detail Pembayaran
                </h6>
                <hr />
                <ul class="list-unstyled">
                  <li class="price-detail">
                    <div class="detail-title">
                      Item
                    </div>
                    <div class="detail-amt">{{ dataOrder.orders.length }} item</div>
                  </li>
                  <li class="price-detail">
                    <div class="detail-title">
                      Total
                    </div>
                    <div class="detail-amt">
                      {{ formatRupiah(dataOrder.invoice.total) }}
                    </div>
                  </li>
                  <li class="price-detail">
                    <div class="detail-title text-danger">
                      Diskon
                    </div>
                    <div class="detail-amt discount-amt text-danger">
                      {{ formatRupiah(dataOrder.invoice.diskon) }}
                    </div>
                  </li>
                  <hr />
                  <li class="price-detail">
                    <div class="detail-title">
                      <b>Sub Total</b>
                    </div>
                    <div class="detail-amt">
                      <b> {{ formatRupiah(subTotal) }}</b>
                    </div>
                  </li>
                  <li class="price-detail mt-1">
                    <div class="detail-title text-primary">
                      Pajak
                    </div>
                    <div class="detail-amt text-primary">
                      {{ formatRupiah(dataOrder.invoice.pajak) }}
                    </div>
                  </li>
                  <li class="price-detail">
                    <div class="detail-title">
                      Ongkos Kirim
                    </div>
                    <div class="detail-amt">
                      {{ formatRupiah(dataOrder.invoice.ongkir) }}
                    </div>
                  </li>
                </ul>
                <hr />
                <ul class="list-unstyled">
                  <li class="price-detail">
                    <div class="detail-title detail-total">
                      Grand Total
                    </div>
                    <div class="detail-amt font-weight-bolder">
                      {{ formatRupiah(dataOrder.invoice.grandTotal) }}
                    </div>
                  </li>
                </ul>
              </div>
            </b-card>
          </div>
        </b-col>
      </b-row>
      <hr />
      <b-row>
        <b-col cols="12" md="8">
          <b-form-group label="Sales" label-cols-md="4">
            <v-select
              :value="dataOrder.sales.id"
              label="nama_lengkap"
              placeholder="Sales"
              :reduce="sales => sales.id"
              :options="salesOption"
              :clearable="true"
              @input="chooseSales"
            />
          </b-form-group>
        </b-col>
      </b-row>
      <hr />

      <b-row>
        <b-col cols="12" md="8">
          <b-form-group label="Metode Pembayaran" label-cols-md="4">
            <v-select
              v-model="dataOrder.pembayaran.statusPembayaran"
              :value="dataOrder.pembayaran.statusPembayaran.value"
              placeholder="Cara Pembayaran"
              label="title"
              :options="pembayaranOption"
              :clearable="false"
              @input="cekStatusPembayaran"
            />
          </b-form-group>
          <hr />
        </b-col>
      </b-row>
      <b-row v-show="dataOrder.pembayaran.kredit">
        <b-col cols="12" md="8">
          <b-form-group label="Tanggal Jatuh Tempo" label-for="tanggalJatuhTempo" label-cols-md="4">
            <b-form-datepicker id="tanggalJatuhTempo" v-model="dataOrder.pembayaran.tanggalJatuhTempo" />
          </b-form-group>
        </b-col>
      </b-row>
      <b-row v-show="dataOrder.pembayaran.kredit">
        <b-col cols="12" md="8">
          <b-form-group label="Down Payment" label-for="down-payment" label-cols-md="4">
            <b-form-input id="down-payment" v-model="dataOrder.pembayaran.downPayment" type="number" @change="dpOnChange($event)" />
          </b-form-group>
        </b-col>
      </b-row>

      <section v-show="caraPembayaran">
        <b-row>
          <b-col cols="12" md="8">
            <b-form-group label="Cara Pembayaran" label-for="cara-pembayaran" label-cols-md="4">
              <v-select
                v-model="dataOrder.pembayaran.jenisPembayaran"
                :value="dataOrder.pembayaran.jenisPembayaran.value"
                placeholder="Cara Pembayaran"
                label="title"
                :options="jenisPembayaranOption"
                :clearable="false"
                @input="cekJenisPembayaran"
              />
            </b-form-group>
          </b-col>
        </b-row>
      </section>

      <b-row v-show="transfer">
        <b-col cols="12" md="8">
          <b-form-group label="Transfer ke" label-for="bank" label-cols-md="4">
            <v-select v-model="dataOrder.pembayaran.bank" placeholder="Nama Bank" label="title" :clearable="false" :options="bankOption" />
          </b-form-group>
        </b-col>
      </b-row>
      <b-row>
        <b-col cols="12" md="8">
          <b-form-group label="Catatan" label-for="catatan" label-cols-md="4">
            <b-form-textarea v-model="dataOrder.catatan" type="text" placeholder="Catatan akan muncul di Invoice" />
          </b-form-group>
        </b-col>
      </b-row>
      <div class="d-flex justify-content-end">
        <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="warning" @click="storeDraft()">
          Simpan Draft
        </b-button>
      </div>
    </b-form>
  </section>
</template>

<script>
import { BButton, BFormDatepicker, BFormGroup, BFormTextarea, BCard, BForm, BFormInput, BRow, BCol } from 'bootstrap-vue'
import Ripple from 'vue-ripple-directive'
import vSelect from 'vue-select'
import store from '@/store'

export default {
  components: {
    // BSV
    BButton,
    BFormDatepicker,
    BForm,
    BFormTextarea,
    BFormGroup,
    BRow,
    BCol,
    BCard,
    BFormInput,
    // 3rd party
    vSelect,
  },
  directives: {
    Ripple,
  },
  props: {
    dataOrder: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      caraPembayaran: true,
      statusKembalian: true,
      pembayaranOption: [
        { title: 'Lunas', value: '0' },
        { title: 'Kredit', value: '1' },
        { title: 'Cash On Delivery (COD)', value: '2' },
      ],
      salesOption: [
        // { nama_lengkap: 'Lulu', id: '0' },
        // { nama_lengkap: 'Lucky Anggara', id: '1' },
        // { nama_lengkap: 'Dadan', id: '2' },
      ],
      jenisPembayaranOption: [
        { title: 'Tunai', value: '0' },
        { title: 'Transfer', value: '1' },
      ],
      bankOption: [
        { title: 'BNI - 0542424', value: '0' },
        { title: 'BRI - 0203203020302', value: '1' },
        { title: 'BCA - asdasdasdasd', value: '1' },
      ],
    }
  },
  computed: {
    subTotal() {
      return parseFloat(this.dataOrder.invoice.total) - parseFloat(this.dataOrder.invoice.diskon)
    },
    transfer() {
      if (this.dataOrder.pembayaran.jenisPembayaran.value === '1') {
        return true
      }
      return false
    },
  },
  mounted() {
    this.loadBank()
    this.loadSales()
  },
  methods: {
    dpOnChange(e) {
      if (e >= this.dataOrder.invoice.grandTotal) {
        this.dataOrder.pembayaran.downPayment = this.dataOrder.invoice.grandTotal
      }
    },
    chooseSales(id) {
      if (id !== null) {
        const sales = this.salesOption.find(d => d.id === id)
        this.dataOrder.sales.id = sales.id
        this.dataOrder.sales.nama_lengkap = sales.nama_lengkap
      } else {
        this.dataOrder.sales.id = ''
        this.dataOrder.sales.nama_lengkap = ''
      }
    },
    cekStatusPembayaran(id) {
      if (id.value === '1') {
        // Kredit
        this.dataOrder.pembayaran.kredit = true
        this.statusKembalian = true
        this.caraPembayaran = true
      } else if (id.value === '2') {
        // COD
        this.dataOrder.pembayaran.kredit = false
        this.statusKembalian = false
        this.caraPembayaran = false
      } else if (id.value === '0') {
        // Lunas
        this.dataOrder.pembayaran.kredit = false
        this.statusKembalian = true
      }
      this.resetInput()
    },
    cekJenisPembayaran(id) {
      if (id.value === '1') {
        this.transfer = true
      } else {
        this.transfer = false
      }
    },
    resetInput() {
      this.jumlahPembayaran = 0
      this.dataOrder.pembayaran.downPayment = 0
      this.dataOrder.pembayaran.tanggalJatuhTempo = ''
    },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
    storeDraft() {
      this.$swal({
        title: 'Simpan ?',
        text: 'Draft Penjualan akan di Simpan',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Ya',
        customClass: {
          confirmButton: 'btn btn-primary',
          cancelButton: 'btn btn-outline-danger ml-1',
        },
        buttonsStyling: false,
      }).then(result => {
        if (result.value) {
          store.commit('app-transaksi-penjualan/ADD_DRAFT_PENJUALAN', this.dataOrder)
          this.$router.push({
            name: 'transaksi-penjualan-draft',
          })
        }
      })
    },
    loadBank() {
      store.dispatch('app-transaksi-penjualan/fetchDataBank', this.dataOrder).then(res => {
        this.bankOption = res.data
      })
    },
    loadSales() {
      store.dispatch('app-pegawai/fetchPegawai').then(res => {
        store.commit('app-pegawai/SET_LIST_PEGAWAI', res.data)
        this.salesOption = store.getters['app-pegawai/getListSales']
      })
    },
  },
}
</script>

<style lang="scss">
@import '@core/scss/vue/libs/vue-select.scss';
.add-new-data-header {
  padding: $options-padding-y $options-padding-x;
  color: $success;

  &:hover {
    background-color: rgba($success, 0.12);
  }
}
</style>

<style lang="scss">
$body-color: #6e6b7b !default;
$font-weight-bolder: 600 !default;
.checkout-options {
  .coupons {
    &:focus-within {
      box-shadow: none;
    }
    input {
      border: none;
      padding-left: 0;
      color: $body-color;
      font-weight: $font-weight-bolder;
      &::placeholder {
        color: $body-color;
        font-weight: $font-weight-bolder;
      }
    }
    .input-group-append {
      margin: 0;
    }
    .input-group-text {
      height: auto;
      font-weight: $font-weight-bolder;
      padding: inherit;
    }
  }
  .price-details {
    .price-title {
      font-weight: $font-weight-bolder;
      // margin-bottom: 0.75rem;
      // margin-top: 1.5rem;
    }
    .price-detail {
      display: flex;
      justify-content: space-between;
      // margin-bottom: 0.75rem;

      .detail-title {
        &.detail-total {
          font-weight: $font-weight-bolder;
        }
      }
    }
  }
}
</style>
