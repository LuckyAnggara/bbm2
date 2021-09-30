<template>
  <div>
    <b-row>
      <b-col lg="12">
        <b-card v-if="dataOrder">
          <div>
            <b-form ref="form" :style="{ height: trHeight }" class="repeater-form" @submit.prevent="repeateAgain">
              <!-- Row Loop -->
              <b-row v-for="(item, index) in dataOrder.detail" :id="item.id" :key="item.id" ref="row">
                <!-- Item Name -->
                <b-col md="2">
                  <b-form-group label="Kode Barang">
                    <b-form-input type="text" placeholder="Kode Barang" v-model="item.kode_barang" />
                  </b-form-group>
                </b-col>
                <b-col md="3">
                  <b-form-group label="Nama Barang">
                    <b-form-input type="text" placeholder="Nama Barang" v-model="item.nama_barang" plaintext />
                  </b-form-group>
                </b-col>
                <!-- Qty Pesanan -->
                <b-col md="2">
                  <b-form-group label="Jumlah Order">
                    <b-form-input type="number" placeholder="-" v-model="item.jumlah" />
                  </b-form-group>
                </b-col>

                <!-- Harga -->
                <b-col md="2">
                  <b-form-group label="Harga">
                    <b-form-input type="number" placeholder="0" v-model="item.harga" />
                  </b-form-group>
                </b-col>
                <!-- Total -->

                <b-col md="2">
                  <b-form-group label="Total">
                    <b-form-input type="text" :value="item.jumlah * item.harga" plaintext />
                  </b-form-group>
                </b-col>

                <!-- Remove Button -->
                <b-col lg="1" md="3" class="mb-50">
                  <b-button v-ripple.400="'rgba(234, 84, 85, 0.15)'" variant="outline-danger" class="mt-0 mt-md-2" @click="removeItem(index)">
                    <feather-icon icon="TrashIcon" class="mr-25" />
                  </b-button>
                </b-col>
              </b-row>
            </b-form>
          </div>

          <b-row class="mt-2">
            <b-col cols="12">
              <hr />
            </b-col>
            <b-col lg="6" md="6" class="mb-50">
              <v-select v-model="tambahBarang" placeholder="Kode Barang" label="kode_barang" :options="selectBarang">
                <template v-slot:option="option">
                  {{ option.kode_barang }} - <b>{{ option.nama }}</b>
                </template>
              </v-select>
            </b-col>
            <b-col lg="3" md="3" class="mb-50">
              <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="primary" @click="repeateAgain">
                <feather-icon icon="PlusIcon" class="mr-25" />
                <span>Tambah Barang</span>
              </b-button>
            </b-col>
          </b-row>
          <!-- submit and reset -->
        </b-card>
      </b-col>
      <b-col lg="4">
        <b-card lg="4">
          <div>
            <h6 class="price-title">
              Detail
            </h6>
            <hr />
            Grand Total :
            {{ formatRupiah(total) }}
          </div>
          <!-- submit and reset -->
          <div class="mt-2">
            <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" type="submit" variant="primary" class="mr-1" @click="store">
              Proses
            </b-button>
          </div>
        </b-card>
      </b-col>
    </b-row>
  </div>
</template>

<script>
import { ref } from '@vue/composition-api'
import { BCard, BForm, BFormGroup, BFormInput, BRow, BCol, BButton } from 'bootstrap-vue'
import { heightTransition } from '@core/mixins/ui/transition'
import Ripple from 'vue-ripple-directive'
import vSelect from 'vue-select'
import { formatRupiah } from '@core/utils/filter'

export default {
  components: {
    BCard,
    BForm,
    BRow,
    BCol,
    BButton,
    BFormGroup,
    BFormInput,
    vSelect,
  },
  directives: {
    Ripple,
  },
  mixins: [heightTransition],
  data() {
    return {
      id: null,
      catatan: 'asdasdasd',
      selectBarang: [],
      tambahBarang: {},
      nextTodoId: 2,
      dataOrder: null,
      user: JSON.parse(localStorage.getItem('userData')),
    }
  },
  mounted() {
    this.initTrHeight()
    this.loadManual()
    this.loadDataBarang()
  },
  created() {
    window.addEventListener('resize', this.initTrHeight)
  },
  destroyed() {
    window.removeEventListener('resize', this.initTrHeight)
  },
  computed: {
    total() {
      let total = 0
      this.dataPO.orders.forEach(x => {
        total += x.harga * x.jumlah
      })
      return total
    },
    dataPO() {
      const form = this.formPenjualan
      form.orders = this.dataOrder.detail
      form.pelanggan = this.dataOrder.cabang_asal.kontak
      form.tanggalTransaksi = this.dataOrder.created_at
      form.catatan = this.catatan

      return form
    },
  },
  methods: {
    formatRupiah,
    grandTotal(x, y) {
      return parseFloat(x) * parseFloat(y)
    },
    loadDataBarang() {
      this.$store.dispatch('app-barang/fetchListBarang', { cabang_id: this.user.cabang_id }).then(res => {
        this.selectBarang = res.data
      })
    },
    loadManual() {
      const { data } = this.$router.currentRoute.params
      const { id } = this.$router.currentRoute.params
      if (data) {
        this.dataOrder = data
      }
      this.$store.dispatch('app-po/showData', { id }).then(res => {
        this.dataOrder = res.data
      })
    },
    repeateAgain() {
      this.dataOrder.detail.push({
        id_barang: this.tambahBarang.id,
        kode_barang: this.tambahBarang.kode_barang,
        nama_barang: this.tambahBarang.nama,
        jumlah: 0,
        harga: 0,
      })
      this.$nextTick(() => {
        this.trAddHeight(this.$refs.row[0].offsetHeight)
      })
    },
    removeItem(index) {
      this.dataOrder.detail.splice(index, 1)
      this.trTrimHeight(this.$refs.row[0].offsetHeight)
    },
    initTrHeight() {
      this.trSetHeight(null)
      this.$nextTick(() => {
        this.trSetHeight(this.$refs.form.scrollHeight)
      })
    },
    success(data) {
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
        name: 'transaksi-penjualan-invoice',
        params: { id: data.id },
      })
    },
    store() {
      this.dataPO.invoice.total = this.total
      this.dataPO.invoice.grandTotal = this.total
      this.$swal({
        title: 'Proses ?',
        text: 'P.O ini akan di proses',
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
          this.$store
            .dispatch('app-transaksi-penjualan/addTransaksi', this.dataPO)
            .then(res => {
              loader.hide()
              if (res.status === 200) {
                this.$store.dispatch('app-po/updateStatus', {
                  id: this.dataOrder.id,
                  status: 'DITERIMA',
                  nomorTransaksi: res.data.nomor_transaksi,
                })
                this.dataOrder.nomorTransaksi = res.data.nomor_transaksi
                this.dataOrder.tanggalTransaksi = res.data.created_at
                this.$store.commit('app-transaksi-penjualan/SET_DATA_INVOICE', this.dataOrder)
                this.success(res.data)
              } else {
                this.error()
              }
            })
            .catch(error => {
              this.error(error)
            })
        }
      })
    },
  },
  setup() {
    const d = new Date()
    d.setMonth(d.getMonth() + 2)
    const formPenjualan = ref({
      catatan: '',
      startIndex: 0,
      nomorTransaksi: '',
      tanggalTransaksi: '',
      nomor: 0,
      status: false, // untuk Status Draft atau Proses
      sales: null, // untuk Status Draft atau Proses
      pelanggan: {
        id: '',
        nama: '',
        alamat: '',
        nomorTelepon: '',
        wic: true,
      },
      invoice: {
        total: 0,
        diskon: 0,
        pajak: 0,
        ongkir: 0,
        grandTotal: 0,
      },
      pembayaran: {
        bank: '',
        jenisPembayaran: { title: 'Tunai', value: '0' },
        kredit: true,
        downPayment: 0,
        tanggalJatuhTempo: d,
        statusPembayaran: { title: 'Kredit', value: '1' },
      },
      orders: [],
      user: JSON.parse(localStorage.getItem('userData')),
    })
    return {
      formPenjualan,
    }
  },
}
</script>

<style lang="scss" scoped>
.repeater-form {
  overflow: hidden;
  transition: 0.35s height;
}
@import '@core/scss/vue/libs/vue-select.scss';
</style>
