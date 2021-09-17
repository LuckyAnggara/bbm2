<template>
  <b-card no-body class="card-statistics">
    <b-card-header>
      <b-card-title>{{ title ? title : 'Statistik Pembelian' }}</b-card-title>
    </b-card-header>
    <b-card-body class="statistics-body">
      <b-row>
        <b-col md="3" sm="6" class="mb-2 mb-md-0 mb-xl-0">
          <b-media no-body>
            <b-media-aside class="mr-2">
              <b-avatar size="48" variant="light-primary">
                <feather-icon size="24" icon="TrendingUpIcon" />
              </b-avatar>
            </b-media-aside>
            <b-media-body class="my-auto">
              <h4 class="font-weight-bolder mb-0">
                {{ formatRupiah(total) }}
              </h4>
              <b-card-text class="font-small-3 mb-0">
                Volume Pembelian
              </b-card-text>
            </b-media-body>
          </b-media>
        </b-col>
        <b-col md="3" sm="6" class="mb-2 mb-md-0 mb-xl-0">
          <b-media no-body>
            <b-media-aside class="mr-2">
              <b-avatar size="48" variant="light-info">
                <feather-icon size="24" icon="ShoppingBagIcon" />
              </b-avatar>
            </b-media-aside>
            <b-media-body class="my-auto">
              <h4 class="font-weight-bolder mb-0">{{ dataTransaksi.length }} Trx</h4>
              <b-card-text class="font-small-3 mb-0">
                Jumlah Transaksi
              </b-card-text>
            </b-media-body>
          </b-media>
        </b-col>
        <!-- <b-col md="3" sm="6" class="mb-2 mb-md-0 mb-xl-0">
          <b-media no-body>
            <b-media-aside class="mr-2">
              <b-avatar size="48" variant="light-success">
                <feather-icon size="24" icon="BoxIcon" />
              </b-avatar>
            </b-media-aside>
            <b-media-body class="my-auto">
              <h4 class="font-weight-bolder mb-0">{{ totalBarang }} Produk</h4>
              <b-card-text class="font-small-3 mb-0"> Produk </b-card-text>
            </b-media-body>
          </b-media>
        </b-col> -->
        <b-col md="3" sm="6" class="mb-2 mb-md-0 mb-xl-0">
          <b-media no-body>
            <b-media-aside class="mr-2">
              <b-avatar size="48" variant="light-danger">
                <feather-icon size="24" icon="BoxIcon" />
              </b-avatar>
            </b-media-aside>
            <b-media-body class="my-auto">
              <h4 class="font-weight-bolder mb-0">{{ formatRupiah(totalTagihan) }}</h4>
              <b-card-text class="font-small-3 mb-0"> Total Tagihan </b-card-text>
            </b-media-body>
          </b-media>
        </b-col>
      </b-row>
    </b-card-body>
  </b-card>
</template>

<script>
import { BCard, BCardHeader, BCardTitle, BCardText, BCardBody, BRow, BCol, BMedia, BMediaAside, BAvatar, BMediaBody } from 'bootstrap-vue'

export default {
  components: {
    BRow,
    BCol,
    BCard,
    BCardHeader,
    BCardTitle,
    BCardText,
    BCardBody,
    BMedia,
    BAvatar,
    BMediaAside,
    BMediaBody,
  },
  props: {
    dataTransaksi: {
      type: Array,
      required: true,
    },
    title: {
      type: String,
    },
  },
  computed: {
    total() {
      let total = 0
      this.dataTransaksi.forEach(v => {
        total += v.invoice.grandTotal
      })
      return total
    },
    totalTagihan() {
      let total = 0
      this.dataTransaksi.forEach(v => {
        total += v.pembayaran.sisaPembayaran
      })
      return total
    },
    // totalBarang() {
    //   let total = 0
    //   this.dataTransaksi.forEach(v => {
    //     v.orders.forEach(x => {
    //       total += x.jumlah
    //     })
    //     // total += v.orders.jumlah
    //   })
    //   return total
    // },
  },
  methods: {
    formatRupiah(value) {
      return `Rp. ${value.toFixed(0).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1.')}`
    },
  },
}
</script>
