<template>
  <div>
    <b-card>
      <b-row>
        <b-col cols="12" class="mb-2">
          <h5 class="mb-0">
            Keranjang Purchase Order (P.O)
          </h5>
          <small class="text-muted">
            Masukan Daftar Barang yang akan di P.O ke Cabang Tujuan.
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

            <!-- Column: Actions -->
            <template #cell(action)="data">
              <div class="text-nowrap">
                <feather-icon icon="TrashIcon" size="16" class="mx-1 text-danger" @click="del(data.index)" />
              </div>
            </template>
          </b-table>
        </b-col>
      </b-row>
    </b-card>

    <b-modal
      id="modal-prevent-closing"
      ref="my-modal"
      title="Jumlah Pesanan"
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
      </b-card-body>
    </b-modal>
  </div>
</template>

<script>
import {
  BRow,
  BCol,
  BModal,
  BFormGroup,
  BCard,
  BCardBody,
  BTable,
  BFormInput,
  // BInputGroupAppend,
} from 'bootstrap-vue'
import vSelect from 'vue-select'
import Ripple from 'vue-ripple-directive'

export default {
  components: {
    BCard,
    BCardBody,
    BRow,
    BCol,
    vSelect,
    BFormGroup,
    BModal,
    BTable,
    BFormInput,
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
      },
      qty: 1,
      detailBarang: {
        nama: null,
        qty: null,
      },
    }
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
          this.dataOrder.orders.splice(index, 1)
        }
      })
    },
    resetModal() {
      this.qty = 1
    },
    handleOk(bvModalEvt) {
      // Prevent modal from closing
      bvModalEvt.preventDefault()
      // Trigger submit handler
      this.handleSubmit()
    },
    handleSubmit() {
      // Push the name to submitted names
      const data = {
        id_barang: this.detailBarang.id,
        kode_barang: this.detailBarang.kode_barang,
        nama_barang: this.detailBarang.nama,
        jumlah: this.qty,
        total: 0,
        harga: 0,
      }
      this.dataOrder.orders.push(data)
      // Hide the modal manually
      this.$nextTick(() => {
        this.$refs['my-modal'].toggle('#toggle-btn')
      })
    },
    showModal(id) {
      if (id !== null) {
        this.detailBarang = this.select.barang.find(d => d.id === id)
        this.select.harga = this.detailBarang.harga
        this.$refs['my-modal'].show()
      }
    },
    myFilter: (option, label, search) => {
      const temp = search.toLowerCase()
      return option.nama.toLowerCase().indexOf(temp) > -1 || option.kode_barang.toLowerCase().indexOf(temp) > -1
    },
    loadDataBarang() {
      if (this.$store.getters['app-barang/getListBarang'].length === 0) {
        this.$store.dispatch('app-barang/fetchListBarang', { cabang_id: this.dataOrder.user.cabang_id }).then(res => {
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
      { key: 'action' },
    ]
    return {
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
