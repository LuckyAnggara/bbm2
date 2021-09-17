<template>
  <b-modal id="modal-terima" title="Terima Barang" ok-title="Proses" cancel-variant="outline-secondary" @hidden="resetModal" @ok="proses">
    <b-card-body>
      <section>
        <b-row>
          <b-col cosl="12" md="12">
            <b-form-group label="Nomor Transaksi" label-cols-md="5">
              <b-form-input v-model="nomorTransaksi" placeholder="Input Nomor Transaksi di Invoice P.O" type="text" />
            </b-form-group>
          </b-col>
        </b-row>
      </section>
    </b-card-body>
  </b-modal>
</template>

<script>
// import store from '@/store'

import { BCol, BRow, BFormGroup, BModal, BFormInput, BCardBody } from 'bootstrap-vue'

export default {
  components: {
    BCol,
    BRow,
    BFormGroup,
    BModal,
    BFormInput,
    BCardBody,
  },
  props: {
    data: {
      default: null,
    },
    id: {
      default: null,
    },
  },
  data() {
    return {
      nomorTransaksi: null,
    }
  },
  methods: {
    resetModal() {
      this.nomorTransaksi = null
      this.show = false
    },
    proses(bvModalEvt) {
      bvModalEvt.preventDefault()
      if (this.data.nomor_transaksi === this.nomorTransaksi) {
        this.$store
          .dispatch('app-po/showDataInvoice', {
            nomor_transaksi: this.nomorTransaksi,
          })
          .then(x => {
            if (x.status === 200) {
              this.$router.push({
                name: 'transaksi-po-invoice',
                params: { id: x.data.id, data_po: this.data },
              })
            } else {
              this.$swal({
                icon: 'error',
                title: 'Oopss..',
                text: 'Cek Kembali nomor Invoice',
                customClass: {
                  confirmButton: 'btn btn-success',
                },
              })
            }
          })
      } else {
        this.$swal({
          icon: 'error',
          title: 'Oopss..',
          text: 'Cek kembali Nomor Transaksi dan Nomor P.O di Dokumen P.O',
          customClass: {
            confirmButton: 'btn btn-success',
          },
        })
      }
    },
  },
}
</script>
