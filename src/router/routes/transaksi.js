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
          to: '/transaksi/penjualan/daftar/',
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
          to: '/transaksi/penjualan/daftar/',
        },
        {
          text: 'Edit',
          active: true,
        },
      ],
    },
  },
  {
    path: '/transaksi/invoice/penjualan/:id',
    name: 'transaksi-penjualan-invoice',
    component: () => import('@/views/transaksi/invoice/InvoicePreviewPenjualan.vue'),
    meta: {
      pageTitle: 'Penjualan',
      breadcrumb: [
        {
          text: 'Transaksi',
          to: '/transaksi/penjualan/daftar/',
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
          to: '/transaksi/pembelian/daftar/',
        },
        {
          text: 'Pembelian',
          active: true,
        },
      ],
    },
  },
  {
    path: '/transaksi/invoice/pembelian/:id',
    name: 'transaksi-pembelian-invoice',
    component: () => import('@/views/transaksi/invoice/InvoicePreviewPembelian.vue'),
    meta: {
      pageTitle: 'Pembelian',
      breadcrumb: [
        {
          text: 'Transaksi',
          to: '/transaksi/pembelian/daftar/',
        },
        {
          text: 'Invoice',
          active: true,
        },
      ],
    },
  },
  {
    path: '/transaksi/po/daftar/',
    name: 'transaksi-po-daftar',
    component: () => import('@/views/transaksi/po/Daftar.vue'),
    meta: {
      pageTitle: 'Purchase Order',
      breadcrumb: [
        {
          text: 'Daftar',
          active: true,
        },
      ],
    },
  },
  {
    path: '/transaksi/po/tambah',
    name: 'transaksi-po-tambah',
    component: () => import('@/views/transaksi/po/Tambah.vue'),
    meta: {
      pageTitle: 'Purchase Order',
      breadcrumb: [
        {
          text: 'Daftar',
          to: '/transaksi/po/daftar/',
        },
        {
          text: 'Tambah',
          active: true,
        },
      ],
    },
  },
  {
    path: '/transaksi/po/detail/:id',
    name: 'transaksi-po-detail',
    component: () => import('@/views/transaksi/po/Dokumen.vue'),
    meta: {
      pageTitle: 'Detail',
      breadcrumb: [
        {
          text: 'Daftar',
          to: '/transaksi/po/daftar/',
        },
        {
          text: 'Detail',
          active: true,
        },
      ],
    },
  },
  {
    path: '/transaksi/po/proses/:id',
    name: 'transaksi-po-proses',
    component: () => import('@/views/transaksi/po/Proses.vue'),
    meta: {
      pageTitle: 'Proses',
      breadcrumb: [
        {
          text: 'Daftar',
          to: '/transaksi/po/daftar/',
        },
        {
          text: 'Proses',
          active: true,
        },
      ],
    },
  },
  {
    path: '/transaksi/po/invoice/:id',
    name: 'transaksi-po-invoice',
    component: () => import('@/views/transaksi/po/component/InvoicePO.vue'),
    meta: {
      pageTitle: 'Proses',
      breadcrumb: [
        {
          text: 'Daftar',
          to: '/transaksi/po/daftar/',
        },
        {
          text: 'Terima',
          active: true,
        },
        {
          text: 'Invoice',
          active: true,
        },
      ],
    },
  },
]
