<template>
  <section>
    <b-card>
      <b-row>
        <b-col md="6">
          <section v-show="form.data_utang.length > 0 ? true : false">
            <b-form-group label="Saldo Akun Setor" label-cols-md="4">
              <b-form-input placeholder="Saldo Akun Setor" :value="formatRupiah(Math.abs(saldoAkunSetor))" readonly />
            </b-form-group>
            <b-form-group label="Total Pembayaran" label-cols-md="4">
              <b-form-input placeholder="Nominal Pembayaran" :value="formatRupiah(total_pembayaran)" readonly />
            </b-form-group>
          </section>
        </b-col>
        <b-col md="6" v-show="total_pembayaran != 0 ? true : false">
          <h6>
            Saldo Akun Setor, adalah Saldo yang berasal dari Setoran Cabang ke Pusat, untuk Pelunasan P.O Cabang
            <br />
            <span class="text-danger">Pastikan total pembayaran tidak melebihi Saldo Akun Setor Cabang</span>
          </h6>
          <b-button variant="primary" class=" mr-1" @click="handleOk">
            Proses
          </b-button>
        </b-col>
      </b-row>
    </b-card>
    <b-card>
      <b-table :fields="tableColumns" :items="form.data_utang" empty-text="Tidak ada data" class="position-relative">
        <!-- Column: Id -->
        <template #cell(id)="data">
          <span>
            {{ data.index + 1 }}
          </span>
        </template>
        <!-- Column: Tanggal -->
        <template #cell(nomor_po)="data">
          <b-link :to="{ name: 'transaksi-po-detail', params: { id: data.item.id, data: data.item } }" class="font-weight-bold">
            {{ data.item.kode_po }}
          </b-link>
        </template>
        <template #cell(nomor_transaksi)="data">
          <span>#{{ data.item.transaksi.nomor_transaksi }}</span>
        </template>

        <!-- Column: Nominal -->
        <template #cell(sisa_pembayaran)="data">
          <span>
            {{ formatRupiah(data.item.transaksi.sisa_pembayaran) }}
          </span>
        </template>

        <!-- Column: Nominal -->
        <template #cell(nominal_pembayaran)="data">
          <b-form-input
            :placeholder="`Maks Rp ${formatRupiah(data.item.transaksi.sisa_pembayaran)}`"
            type="number"
            v-model="data.item.jumlah_pembayaran"
            @change="cekMax(data)"
          />
        </template>

        <template #cell(lunas)="data">
          <b-form-checkbox v-model="data.item.lunas_check" @change="lunas(data)">
            Lunas
          </b-form-checkbox>
        </template>
      </b-table>
    </b-card>
  </section>
</template>

<script>
import store from '@/store'
import { ref } from '@vue/composition-api'
import { BLink, BCard, BRow, BCol, BButton, BFormInput, BFormCheckbox, BFormGroup, BTable } from 'bootstrap-vue'

export default {
  components: {
    BCard,
    BLink,
    BButton,
    BRow,
    BCol,
    BFormInput,
    BFormGroup,
    BFormCheckbox,
    BTable,
  },
  data() {
    return {}
  },
  mounted() {
    this.loadDataUtangPo()
    this.loadSaldoAkun()
  },
  computed: {
    total_pembayaran() {
      let total = 0
      this.form.data_utang.forEach(v => {
        total += parseFloat(v.jumlah_pembayaran)
      })
      return total
    },
  },
  methods: {
    loadDataUtangPo(dd = null, ddd = null) {
      store
        .dispatch('app-keuangan/getUtangPo', {
          cabang: this.userData.cabang_id,
          dd: dd === null ? '' : dd,
          ddd: ddd === null ? '' : ddd,
        })
        .then(res => {
          this.form.data_utang = res.data.filter(x => x.transaksi.sisa_pembayaran > 0)
        })
    },
    loadSaldoAkun() {
      store
        .dispatch('app-keuangan/fetchSaldoAkun', {
          cabang_id: this.userData.cabang_id,
          akun_id: 65,
          tahun: new Date().getFullYear(),
        })
        .then(res => {
          this.saldoAkunSetor = res.data
        })
    },
    handleOk() {
      this.form.nominal_pembayaran = this.total_pembayaran
      if (this.total_pembayaran > Math.abs(this.saldoAkunSetor)) {
        this.$swal({
          icon: 'error',
          title: 'Pembayaran melebihi Saldo Akun Setor Cabang',
          customClass: {
            confirmButton: 'btn btn-success',
          },
        })
        return
      }
      if (this.form.nominal_pembayaran === '' || this.form.nominal_pembayaran === 'Rp. 0' || this.form.data_utang.length < 1) {
        this.$swal({
          icon: 'error',
          title: 'Isi Form Pembayaran dengan Benar',
          customClass: {
            confirmButton: 'btn btn-success',
          },
        })
        return
      }
      if (this.form.nominal_pembayaran === '' || this.form.nominal_pembayaran === 'Rp. 0' || this.form.data_utang.length < 1) {
        this.$swal({
          icon: 'error',
          title: 'Isi Form Pembayaran dengan Benar',
          customClass: {
            confirmButton: 'btn btn-success',
          },
        })
        return
      }
      this.$swal({
        title: 'Proses pembayaran ?',
        text: `Total Pembayaran adalah ${this.formatRupiah(this.form.nominal_pembayaran)}`,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Proses!',
        customClass: {
          confirmButton: 'btn btn-primary',
          cancelButton: 'btn btn-outline-danger ml-1',
        },
        buttonsStyling: false,
      }).then(result => {
        if (result.value) {
          this.form.user = this.userData
          store.dispatch('app-keuangan/storeBatchUtang', this.form).then(x => {
            if (x.status === 200) {
              this.$swal({
                icon: 'success',
                title: 'Transaksi berhasil!',
                customClass: {
                  confirmButton: 'btn btn-success',
                },
              })
              this.$router.push({
                name: 'keuangan-utang-piutang',
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
    lunas(x) {
      if (x.item.lunas_check === true) {
        this.form.data_utang[x.index].jumlah_pembayaran = x.item.transaksi.sisa_pembayaran
      } else {
        this.form.data_utang[x.index].jumlah_pembayaran = 0
      }
    },
    cekMax(x) {
      if (x.item.jumlah_pembayaran === '') {
        this.form.data_utang[x.index].jumlah_pembayaran = 0
      }
      if (x.item.jumlah_pembayaran >= x.item.transaksi.sisa_pembayaran) {
        this.form.data_utang[x.index].lunas_check = true
        this.form.data_utang[x.index].jumlah_pembayaran = x.item.transaksi.sisa_pembayaran
      } else {
        this.form.data_utang[x.index].lunas_check = false
      }
    },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
  },

  setup() {
    const userData = JSON.parse(localStorage.getItem('userData'))

    const saldoAkunSetor = ref(0)
    const form = ref({
      supplier: '',
      data_utang: [],
      transfer: false,
      bank: '',
      nominal_pembayaran: 0,
      user: {},
    })
    const tableColumns = [
      { key: 'id', label: '#', sortable: false },
      { key: 'nomor_po', sortable: false },
      { key: 'nomor_transaksi', sortable: false },
      { key: 'sisa_pembayaran', sortable: false },
      { key: 'nominal_pembayaran', sortable: false },
      { key: 'lunas' },
    ]

    return {
      saldoAkunSetor,
      userData,
      form,
      tableColumns,
    }
  },
}
</script>
