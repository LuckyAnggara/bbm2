<template>
  <section>
    <b-row class="match-height">
      <b-col lg="9" md="9" sm="12" cols="12">
        <b-card>
          <b-row>
            <b-col lg="12" cols="12">
              <b-form-group label="Tahun Buku" label-cols-md="3">
                <v-select v-model="tahun" :options="option" :clearable="false" />
              </b-form-group>
            </b-col>
            <b-col lg="12" cols="12">
              <b-form-group label="Kode Akun" label-cols-md="3">
                <b-form-input readonly v-model="dataMaster.kode_akun" />
              </b-form-group>
            </b-col>
            <b-col lg="12" cols="12">
              <b-form-group label="Nama Akun" label-cols-md="3">
                <b-form-input readonly v-model="dataMaster.nama" />
              </b-form-group>
            </b-col>
            <b-col lg="12" cols="12">
              <b-form-group label="Saldo Akun" label-cols-md="3">
                <b-form-input readonly v-model="saldo" />
              </b-form-group>
            </b-col>
          </b-row>
        </b-card>
      </b-col>
      <b-col cols="12" md="3" sm="12" xl="3">
        <b-card>
          <!-- Button: Tambah Beban -->
          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" v-b-modal.modal-beban variant="primary" class="mb-75" block>
            Tambah Beban
          </b-button>

          <!-- Button: Tambah Sub Akun -->
          <b-button v-ripple.400="'rgba(186, 191, 199, 0.15)'" v-b-modal.modal-sub-akun variant="outline-success" class="mb-75" block>
            Tambah Sub Akun
          </b-button>

          <!-- Button: Download -->
          <b-button v-ripple.400="'rgba(186, 191, 199, 0.15)'" variant="success" class="mb-75" block>
            Download
          </b-button>
        </b-card>
      </b-col>
      <b-col lg="12" cols="12">
        <b-card>
          <b-tabs pills>
            <b-tab title="Master" lazy>
              <master-table :data-list="dataKomponenBeban" />
            </b-tab>
            <b-tab title="Detail" lazy>
              <detail-table @destroy="destroyId" :data-list="dataDetailBeban" />
            </b-tab>
          </b-tabs>
        </b-card>
      </b-col>
    </b-row>
    <b-modal
      id="modal-beban"
      ref="modal-beban"
      ok-variant="primary"
      ok-title="Submit"
      modal-class="modal-primary"
      size="lg"
      centered
      title="Tambah Beban"
      @hidden="resetFormBeban"
      @ok="submitBeban"
    >
      <b-row>
        <b-col lg="12" cols="12">
          <b-form-group label="Tanggal" label-cols-md="3">
            <flat-pickr v-model="formBeban.tanggal" class="form-control" :config="date.config" placeholder="Filter By Tanggal" />
          </b-form-group>
        </b-col>
        <b-col lg="12" cols="12">
          <b-form-group label="Nama Beban" label-cols-md="3">
            <v-select
              v-model="formBeban.subAkun"
              label="nama"
              :reduc="x => x.id"
              :options="dataKomponenBeban"
              placeholder="Pilih Akun Beban Operasional"
              :clearable="false"
            />
          </b-form-group>
        </b-col>
        <b-col lg="12" cols="12">
          <b-form-group label="Nominal" label-cols-md="3">
            <b-form-input type="number" v-model="formBeban.nominal" />
          </b-form-group>
          <hr />
        </b-col>
        <b-col>
          <b-form-group label="Cara Pembayaran" label-cols-md="3">
            <b-form-input value="TUNAI" readonly />
            <!-- <v-select v-model="beban.caraPembayaran" placeholder="Cara Pembayaran" label="title" :options="caraPembayaran" :clearable="false" /> -->
          </b-form-group>
        </b-col>
        <b-col cols="6" md="12">
          <b-form-group label="Kas" label-cols-md="3">
            <v-select v-model="formBeban.kas" placeholder="Kas yang digunakan" label="nama" :options="kasTunai" :clearable="false" />
          </b-form-group>
        </b-col>
        <b-col lg="12" cols="12">
          <b-form-group label="Saldo" label-cols-md="3" v-if="formBeban.kas !== null ? true : false">
            <b-form-input type="text" :value="formBeban.kas.saldo !== null ? formatRupiah(formBeban.kas.saldo) : 0" readonly />
          </b-form-group>
          <hr />
        </b-col>
        <b-col lg="12" cols="12">
          <b-form-group label="Catatan" label-cols-md="3">
            <b-form-textarea v-model="formBeban.catatan" />
          </b-form-group>
        </b-col>
      </b-row>
    </b-modal>
    <b-modal
      id="modal-sub-akun"
      ref="modal-sub-akun"
      ok-variant="success"
      ok-title="Submit"
      modal-class="modal-success"
      centered
      title="Tambah Sub Akun Beban"
      @hidden="resetFormAkun"
      @ok="submitAkun"
    >
      <b-row>
        <b-col lg="12" cols="12">
          <b-form-group label="Kode Akun" label-cols-md="3">
            <b-form-input type="text" v-model="kodeAkun" readonly />
          </b-form-group>
        </b-col>
        <b-col lg="12" cols="12">
          <b-form-group label="Nama Akun" label-cols-md="3">
            <b-form-input v-model="formSubAkun.nama_akun" />
          </b-form-group>
        </b-col>
      </b-row>
    </b-modal>
  </section>
</template>

<script>
import store from '@/store'

import { BCard, BTab, BTabs, BFormGroup, BRow, BCol, BFormInput, BFormTextarea, BButton, BModal, VBModal } from 'bootstrap-vue'
import Ripple from 'vue-ripple-directive'
import vSelect from 'vue-select'
import flatPickr from 'vue-flatpickr-component'
import MasterTable from './component/MasterTable.vue'
import DetailTable from './component/DetailTable.vue'

export default {
  components: {
    vSelect,
    BTab,
    BTabs,
    BFormTextarea,
    BModal,
    BButton,
    BCard,
    BRow,
    BCol,
    BFormInput,
    BFormGroup,
    flatPickr,
    MasterTable,
    DetailTable,
  },
  directives: {
    Ripple,
    'b-modal': VBModal,
  },
  data() {
    return {
      formBeban: {
        subAkun: '',
        nominal: 0,
        catatan: '',
        kas: null,
        tanggal: new Date(),
      },
      formSubAkun: {
        kode_akun: '',
        nama_akun: '',
      },
      date: {
        config: {
          defaultDate: 'today',
          altFormat: 'd F y',
          altInput: true,
          dateFormat: 'Y-m-d',
        },
      },
      tahun: '2021',
      option: ['2021', '2022', '2023'],
      dataMaster: {},
      dataKomponenBeban: [],
      dataDetailBeban: [],
      kasTunai: [],
      userData: JSON.parse(localStorage.getItem('userData')),
    }
  },
  watch: {
    tahun(x) {
      this.loadOperasional(x)
    },
  },
  computed: {
    saldo() {
      let saldo = 0
      this.dataDetailBeban.forEach(x => {
        saldo += x.nominal
      })
      return this.formatRupiah(saldo)
    },
    kodeAkun() {
      if (this.dataKomponenBeban.length > 0) {
        const headAkun = this.dataMaster.kode_akun
        const lastElement = this.dataKomponenBeban[this.dataKomponenBeban.length - 1]
        const prefix = lastElement.kode_akun.split('-')
        const kodeAkun = `${headAkun}-${parseFloat(prefix[1]) + parseFloat(1)}`
        return kodeAkun
      }
      return ''
    },
  },
  mounted() {
    this.loadAwal()
    this.loadDataKas()
  },
  methods: {
    cekValidasiAkun(modal) {
      modal.preventDefault()
      if (this.formSubAkun.nama_akun === '') {
        this.error('Sub Akun')
        return false
      }
      return true
    },
    cekValidasiBeban(modal) {
      modal.preventDefault()
      const beban = this.formBeban
      if (beban.kas.saldo < beban.nominal) {
        this.$swal({
          title: 'Error!',
          text: `Saldo kas ${beban.kas.nama} kurang`,
          icon: 'error',
          customClass: {
            confirmButton: 'btn btn-primary',
          },
          buttonsStyling: false,
        })
        return false
      }
      if (beban.subAkun === '' || beban.tanggal === '' || beban.catatan === '') {
        this.error('Beban')
        if (beban.nominal === 0) {
          this.$swal({
            title: 'Error!',
            text: 'Nominal Beban Rp. 0',
            icon: 'error',
            customClass: {
              confirmButton: 'btn btn-primary',
            },
            buttonsStyling: false,
          })
          return false
        }
        return false
      }
      return true
    },
    resetFormAkun() {
      this.formSubAkun.nama_akun = ''
    },
    resetFormBeban() {
      this.formBeban.nominal = 0
      this.formBeban.tanggal = ''
      this.formBeban.catatan = ''
      this.formBeban.subAkun = ''
      this.formBeban.kas = null
    },
    loadOperasional(x = null) {
      let tahun = x
      if (x === null) {
        const d = new Date()
        tahun = d.getFullYear()
      }
      store
        .dispatch('app-keuangan/fetchOperasional', {
          tahun,
          cabang: this.userData.cabang_id,
        })
        .then(res => {
          store.commit('app-keuangan/SET_DATA_BEBAN_OPERASIONAL', res.data)
          this.dataMaster = store.getters['app-keuangan/getDataBebanOperasional']
          this.dataKomponenBeban = store.getters['app-keuangan/getDataBebanOperasional'].komponen
          this.dataDetailBeban = store.getters['app-keuangan/getDataBebanOperasional'].detail
        })
    },
    loadDataKas() {
      this.$store
        .dispatch('app-cabang/fetchDataKas', {
          cabang_id: this.userData.cabang_id,
        })
        .then(res => {
          this.kasTunai = res.data.filter(x => x.komponen === '1.1.2')
        })
    },
    success() {
      this.$swal({
        title: 'Success!',
        text: 'Beban berhasil di buat!!',
        icon: 'success',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
    },
    error(title) {
      this.$swal({
        title: 'Error!',
        text: `Form  ${title} belum lengkap !!`,
        icon: 'error',
        customClass: {
          confirmButton: 'btn btn-primary',
        },
        buttonsStyling: false,
      })
    },
    loadAwal() {
      this.loadOperasional()
    },
    formatRupiah(value) {
      return `Rp. ${value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
    submitBeban(modal) {
      if (this.cekValidasiBeban(modal)) {
        const loader = this.$loading.show({})
        const output = {
          user_id: this.userData.id,
          cabang_id: this.userData.cabang_id,
          master_akun_id: this.formBeban.subAkun.id,
          nominal: this.formBeban.nominal,
          catatan: this.formBeban.catatan,
          tanggal: this.formBeban.tanggal,
          kas: this.formBeban.kas,
        }
        store.dispatch('app-keuangan/storeBeban', output).then(res => {
          loader.hide()
          if (res.status === 200) {
            store.commit('app-keuangan/ADD_DATA_BEBAN_OPERASIONAL', res.data.master)
            this.success()
            this.$refs['modal-beban'].hide()
          } else {
            this.error()
          }
        })
      }
      return false
    },
    submitAkun(modal) {
      if (this.cekValidasiAkun(modal)) {
        const loader = this.$loading.show({})
        const output = {
          jenis_akun_id: this.dataMaster.jenis_akun_id,
          saldo_normal: this.dataMaster.saldo_normal,
          komponen: this.dataMaster.kode_akun,
          kode_akun: this.kodeAkun,
          nama: `${this.dataMaster.nama}-${this.formSubAkun.nama_akun}`,
          cabang_id: this.userData.cabang_id,
        }
        store.dispatch('app-keuangan/storeAkun', output).then(res => {
          loader.hide()
          if (res.status === 200) {
            store.commit('app-keuangan/ADD_DATA_KOMPONEN_BEBAN_OPERASIONAL', res.data)
            this.$refs['modal-sub-akun'].hide()
            this.success()
          } else {
            this.error()
          }
        })
      }
      return false
    },
    destroyId(data) {
      const { id } = data.item
      this.$swal({
        title: 'Delete data ?',
        text: 'Data beban akan di hapus',
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
          store.dispatch('app-keuangan/removeBeban', id).then(x => {
            if (x.status === 200) {
              store.commit('app-keuangan/REMOVE_DETAIL_BEBAN_OPERASIONAL', id)
              store.dispatch('app-keuangan/removeJurnal', x.data.jurnal).then(d => {
                if (d.status === 200) {
                  this.$swal({
                    icon: 'success',
                    title: 'Deleted!',
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
}
</script>
<style lang="scss" scoped>
@import '@core/scss/vue/libs/vue-flatpicker.scss';
@import '@core/scss/vue/libs/vue-select.scss';
.per-page-selector {
  width: 90px;
}
</style>
