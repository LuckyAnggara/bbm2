<template>
  <div>
    <!-- <e-commerce-checkout-step-cart-products /> -->
    <!-- Products List -->
    <b-form>
      <b-row>
        <b-col cols="12" class="mb-2">
          <h5 class="mb-0">
            Keranjang Belanja
          </h5>
          <small class="text-muted">
            Masukan Daftar Barang Pembelian.
          </small>
        </b-col>
        <b-col>
          <b-form-group label="Nama / Kode Barang" label-cols-md="3">
            <v-select
              placeholder="Nama / Kode Barang"
              label="nama"
              :filter-by="myFilter"
              :reduce="barang => barang.id"
              :options="loadDataBarang()"
              @input="showModal"
            >
              <template v-slot:option="option">
                {{ option.kode_barang }} - <b>{{ option.nama }}</b>
              </template>
            </v-select>
          </b-form-group>
        </b-col>
        <b-col cols="12" class="mb-2">
          <b-table responsive primary-key="id" :fields="field" :items="this.dataOrder.orders" show-empty empty-text="Tidak ada data" class="position-relative">
            <!-- Column: Id -->
            <template #cell(id)="data">
              <span>
                {{ data.index + 1 }}
              </span>
            </template>

            <!-- Column: harga -->
            <template #cell(harga)="data">
              <span>
                {{ formatRupiah(data.item.harga) }}
              </span>
            </template>

            <!-- Column: Total -->
            <template #cell(total)="data">
              <span>
                {{ formatRupiah(data.item.total) }}
              </span>
            </template>

            <!-- Column: Actions -->
            <template #cell(action)="data">
              <div class="text-nowrap">
                <feather-icon icon="TrashIcon" size="16" class="mx-1 text-danger" @click="del(data.index)" />
              </div>
            </template>
          </b-table>
        </b-col>
        <b-col cols="12" md="6">
          <div class="checkout-options">
            <b-card>
              <div class="price-details">
                <h6 class="price-title">
                  Pajak dan Ongkos Kirim
                </h6>
                <hr />

                <b-form-group label="Pajak" label-for="pajak" label-cols-md="6">
                  <b-input-group prepend="%" append="%">
                    <b-form-spinbutton v-model="pajakpersen" min="1" max="100" />
                    <!-- <b-form-input id="h-first-name" placeholder="0" type="number" /> -->
                  </b-input-group>
                </b-form-group>
                <b-form-group label="Ongkos Kirim" label-for="ongkir" label-cols-md="6">
                  <b-form-input v-model="dataOrder.invoice.ongkir" trim type="number" />
                </b-form-group>
              </div>
            </b-card>
          </div>
        </b-col>
        <b-col cols="12" md="6">
          <div class="checkout-options">
            <b-card>
              <div class="price-details">
                <h6 class="price-title">
                  Detail
                </h6>
                <hr />
                <ul class="list-unstyled">
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
                  <li class="price-detail">
                    <div class="detail-title">
                      Sub Total
                    </div>
                    <div class="detail-amt">
                      {{ formatRupiah(subTotal) }}
                    </div>
                  </li>
                  <li class="price-detail">
                    <div class="detail-title text-primary">
                      Pajak
                    </div>
                    <div class="detail-amt text-primary">
                      {{ formatRupiah(dataOrder.invoice.pajak) }}
                    </div>
                  </li>
                  <li class="price-detail">
                    <div class="detail-title mt-1">
                      Ongkos Kirim
                    </div>
                    <div class="detail-amt text-primary">
                      {{ formatRupiah(dataOrder.invoice.ongkir) }}
                    </div>
                    <!-- <div class="detail-amt">
                      <b-form-input v-model="dataOrder.invoice.ongkir" trim type="number" />
                    </div> -->
                  </li>
                </ul>
                <hr />
                <ul class="list-unstyled">
                  <li class="price-detail">
                    <div class="detail-title detail-total">
                      Grand Total
                    </div>
                    <div class="detail-amt font-weight-bolder">
                      {{ formatRupiah(this.dataOrder.invoice.grandTotal) }}
                    </div>
                  </li>
                </ul>
              </div>
            </b-card>
          </div>
        </b-col>
      </b-row>
    </b-form>

    <b-modal
      id="modal-prevent-closing"
      ref="my-modal"
      title="Submit Your Name"
      ok-title="Submit"
      cancel-variant="outline-secondary"
      @show="resetModal"
      @hidden="resetModal"
      @ok="handleOk"
    >
      <!-- <b-modal id="modal-default" ref="my-modal" ok-only ok-title="Submit" centered :title="detailBarang.nama"> -->
      <b-card-body>
        <b-col cols="12">
          <b-form-group label="Quantity" label-for="quantity" class="mb-2">
            <b-form-input v-model="qty" trim type="number" />
          </b-form-group>
        </b-col>
        <!-- <b-col cols="12">
          <b-form-group label="Harga Satuan" label-for="nama-pelanggan-lama" class="mb-2">
            <v-select
              v-model="selectHarga"
              placeholder="Satuan"
              label="nama_satuan"
              :options="select.harga"
              :reduce="harga => harga.id"
              :value="selectHarga.id"
            />
          </b-form-group>
        </b-col> -->
        <b-col cols="12">
          <b-form-group label="Harga Beli" label-for="harga-beli" class="mb-2">
            <b-form-input v-model="hargaBeli" trim type="number" />
          </b-form-group>
        </b-col>
        <b-col cols="12">
          <b-form-group label="Diskon" label-for="diskon" class="mb-2">
            <b-form-input v-model="diskon" trim type="number" />
          </b-form-group>
        </b-col>
      </b-card-body>
    </b-modal>
  </div>
</template>

<script>
import {
  BRow,
  BFormSpinbutton,
  BCol,
  BModal,
  BFormGroup,
  BForm,
  BCard,
  BCardBody,
  BInputGroup,
  BFormInput,
  BTable,
  // BInputGroupAppend,
} from 'bootstrap-vue'
import vSelect from 'vue-select'
import Ripple from 'vue-ripple-directive'

export default {
  components: {
    BInputGroup,
    BFormSpinbutton,
    BCard,
    BCardBody,
    BForm,
    BRow,
    BCol,
    vSelect,
    BFormInput,
    BFormGroup,
    BModal,
    BTable,
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
      select: {
        barang: [],
        harga: [],
      },
      selectHarga: {
        id: 0,
      },
      qty: 1,
      diskon: 0,
      hargaBeli: 0,
      pajakpersen: 0,
      detailBarang: {
        nama: null,
        qty: null,
      },
    }
  },

  computed: {
    ongkir() {
      return this.dataOrder.invoice.ongkir
    },
    subTotal() {
      return parseFloat(this.dataOrder.invoice.total) - parseFloat(this.dataOrder.invoice.diskon)
    },
  },
  watch: {
    pajakpersen(ss) {
      if (ss === '') {
        this.pajakpersen = 0
      } else {
        const totalBFT = parseFloat(this.dataOrder.invoice.total) - parseFloat(this.dataOrder.invoice.diskon)
        this.dataOrder.invoice.pajak = (totalBFT * parseFloat(this.pajakpersen)) / 100
        this.dataOrder.invoice.grandTotal = parseFloat(totalBFT) + parseFloat(this.dataOrder.invoice.pajak) + parseFloat(this.dataOrder.invoice.ongkir)
      }
    },
    ongkir() {
      if (this.dataOrder.invoice.ongkir === '') {
        this.dataOrder.invoice.ongkir = 0
      } else {
        const totalBFT = parseFloat(this.dataOrder.invoice.total) - parseFloat(this.dataOrder.invoice.diskon)
        this.dataOrder.invoice.pajak = (totalBFT * parseFloat(this.pajakpersen)) / 100
        this.dataOrder.invoice.grandTotal = parseFloat(totalBFT) + parseFloat(this.dataOrder.invoice.pajak) + parseFloat(this.dataOrder.invoice.ongkir)
      }
    },
  },
  mounted() {
    this.loadDataBarang()
  },
  methods: {
    del(index) {
      this.$swal({
        title: 'Delete data ?',
        text: 'Data barang akan di hapus dari keranjang',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Ya !!',
        customClass: {
          confirmButton: 'btn btn-primary',
          cancelButton: 'btn btn-outline-danger ml-1',
        },
        buttonsStyling: false,
      }).then(result => {
        if (result.value) {
          this.calculateTotalMinus(this.dataOrder.orders[index])
          this.dataOrder.orders.splice(index, 1)
        }
      })
    },
    resetModal() {
      this.detailBarang.qty = 1
      this.diskon = 0
      this.selectHarga = ''
      this.hargaBeli = 0
      this.qty = 1
    },
    handleInput(event) {
      this.dataOrder.invoice.ongkir = this.formatRupiah(event)
    },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
    handleOk(bvModalEvt) {
      // Prevent modal from closing
      bvModalEvt.preventDefault()
      // Trigger submit handler
      this.handleSubmit()
    },
    handleSubmit() {
      // Push the name to submitted names
      const grandTotal = this.qty * this.hargaBeli - this.diskon
      const data = {
        id_barang: this.detailBarang.id,
        kode_barang: this.detailBarang.kode_barang,
        nama_barang: this.detailBarang.nama,
        jumlah: this.qty,
        harga: this.hargaBeli,
        diskon: this.diskon,
        total: grandTotal,
      }
      this.dataOrder.orders.push(data)
      this.calculateTotal(data)
      // Hide the modal manually
      this.$nextTick(() => {
        this.$refs['my-modal'].toggle('#toggle-btn')
      })
    },
    calculateTotal(order) {
      this.dataOrder.invoice.total = parseFloat(this.dataOrder.invoice.total) + parseFloat(order.total)
      this.dataOrder.invoice.diskon = parseFloat(order.diskon)
      const totalBeforeTax = parseFloat(this.dataOrder.invoice.total) - parseFloat(this.dataOrder.invoice.diskon)
      this.dataOrder.invoice.pajak = (parseFloat(totalBeforeTax) * this.pajakpersen) / 100
      this.dataOrder.invoice.grandTotal = parseFloat(totalBeforeTax) + parseFloat(this.dataOrder.invoice.pajak) + parseFloat(this.dataOrder.invoice.ongkir)
    },
    calculateTotalMinus(order) {
      this.dataOrder.invoice.total = parseFloat(this.dataOrder.invoice.total) - parseFloat(order.total)
      this.dataOrder.invoice.diskon = parseFloat(this.dataOrder.invoice.diskon) - parseFloat(order.diskon)
      const totalBeforeTax = parseFloat(this.dataOrder.invoice.total) - parseFloat(this.dataOrder.invoice.diskon)
      this.dataOrder.invoice.pajak = (parseFloat(totalBeforeTax) * this.pajakpersen) / 100
      this.dataOrder.invoice.grandTotal = parseFloat(totalBeforeTax) + parseFloat(this.dataOrder.invoice.pajak) + parseFloat(this.dataOrder.invoice.ongkir)
    },
    showModal(id) {
      if (id !== null) {
        this.detailBarang = this.select.barang.find(d => d.id === id)
        this.select.harga = this.detailBarang.harga
        this.selectHarga = this.detailBarang.harga['0']
        this.$refs['my-modal'].show()
      }
    },
    myFilter: (option, label, search) => {
      const temp = search.toLowerCase()
      return option.nama.toLowerCase().indexOf(temp) > -1 || option.kode_barang.toLowerCase().indexOf(temp) > -1
    },
    loadDataBarang() {
      if (this.$store.getters['app-barang/getListBarang'].length === 0) {
        this.$store.dispatch('app-barang/fetchListBarang', { cabang_id: this.user.cabang_id }).then(res => {
          this.$store.commit('app-barang/SET_LIST_BARANG', res.data)
          const data = this.$store.getters['app-barang/getListBarang']
          this.select.barang = data
          return data
        })
      }
      this.select.barang = this.$store.getters['app-barang/getListBarang']
      return this.$store.getters['app-barang/getListBarang']
    },
  },

  setup() {
    const field = [
      { key: 'id', label: '#', sortable: true },
      { key: 'kode_barang', sortable: true },
      { key: 'nama_barang', sortable: true },
      { key: 'jumlah', sortable: true },
      { label: 'harga jual', key: 'harga', sortable: true },
      { key: 'diskon', sortable: true },
      { key: 'total', sortable: true },
      { key: 'action' },
    ]
    const user = JSON.parse(localStorage.getItem('userData'))
    return {
      user,
      field,
    }
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
