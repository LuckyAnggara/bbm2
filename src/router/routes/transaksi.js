export default [
  {
    path: '/transaksi/penjualan/daftar',
    name: 'transaksi-penjualan-daftar',
    component: () => import('@/views/transaksi/penjualan/DaftarTransaksi.vue'),
    meta: {
      pageTitle: 'Transaksi',
      breadcrumb: [
        {
          text: 'Penjualan',
        },
        {
          text: 'Daftar',
          active: true,
        },
      ],
    },
  },
  {
    path: '/transaksi/penjualan/draft',
    name: 'transaksi-penjualan-draft',
    component: () => import('@/views/transaksi/penjualan/DaftarDraft.vue'),
    meta: {
      pageTitle: 'Transaksi',
      breadcrumb: [
        {
          text: 'Penjualan',
        },
        {
          text: 'Draft',
          active: true,
        },
      ],
    },
  },
  {
    path: '/transaksi/penjualan/tambah',
    name: 'transaksi-penjualan-tambah',
    component: () => import('@/views/transaksi/penjualan/Penjualan.vue'),
    meta: {
      pageTitle: 'Penjualan',
      breadcrumb: [
        {
          text: 'Transaksi',
        },
        {
          text: 'Penjualan',
          active: true,
        },
      ],
    },
  },
  {
    path: '/transaksi/penjualan/edit/:id',
    name: 'transaksi-penjualan-edit',
    component: () => import('@/views/transaksi/penjualan/edit/EditPenjualan.vue'),
    meta: {
      pageTitle: 'Penjualan',
      breadcrumb: [
        {
          text: 'Transaksi',
        },
        {
          text: 'Penjualan',
        },
        {
          text: 'Edit',
          active: true,
        },
      ],
    },
  },
  {
    path: '/transaksi/invoice',
    name: 'transaksi-penjualan-invoice',
    component: () => import('@/views/transaksi/invoice/InvoicePreviewPenjualan.vue'),
    meta: {
      pageTitle: 'Penjualan',
      breadcrumb: [
        {
          text: 'Transaksi',
        },
        {
          text: 'Invoice',
          active: true,
        },
      ],
    },
  },
  {
    path: '/transaksi/pembelian/daftar',
    name: 'transaksi-pembelian-daftar',
    component: () => import('@/views/transaksi/pembelian/DaftarTransaksi.vue'),
    meta: {
      pageTitle: 'Transaksi',
      breadcrumb: [
        {
          text: 'Pembelian',
        },
        {
          text: 'Daftar',
          active: true,
        },
      ],
    },
  },
  {
    path: '/transaksi/pembelian/draft',
    name: 'transaksi-pembelian-draft',
    component: () => import('@/views/transaksi/pembelian/DaftarDraft.vue'),
    meta: {
      pageTitle: 'Transaksi',
      breadcrumb: [
        {
          text: 'Pembelian',
        },
        {
          text: 'Draft',
          active: true,
        },
      ],
    },
  },
  {
    path: '/transaksi/pembelian/tambah',
    name: 'transaksi-pembelian-tambah',
    component: () => import('@/views/transaksi/pembelian/Pembelian.vue'),
    meta: {
      pageTitle: 'Pembelian',
      breadcrumb: [
        {
          text: 'Transaksi',
        },
        {
          text: 'Pembelian',
          active: true,
        },
      ],
    },
  },
]
