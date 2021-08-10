<template>
  <b-row class="match-height">
    <b-col lg="8">
      <form-data />
    </b-col>
    <!-- <b-col lg="4">
      <detail-harga />
    </b-col> -->
  </b-row>
</template>

<script>
import { BRow, BCol } from 'bootstrap-vue'
import FormData from './FormData.vue'
// import DetailHarga from './Tambah/DetailHarga.vue'

export default {
  components: {
    BRow,
    BCol,
    FormData,
    // DetailHarga,
  },
}
</script>
