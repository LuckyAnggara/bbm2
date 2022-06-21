export default [
  {
    path: '/laporan/persediaan/',
    name: 'laporan-persediaan',
    component: () => import('@/views/laporan/persediaan/Master.vue'),
    meta: {
      resource: 'laporan_persediaan',
      pageTitle: 'Laporan',
      breadcrumb: [
        {
          text: 'Persediaan',
          active: true,
        },
      ],
    },
  },
  {
    path: '/laporan/transaksi/',
    name: 'laporan-transaksi',
    component: () => import('@/views/laporan/transaksi/Master.vue'),
    meta: {
      resource: 'laporan_transaksi',
      pageTitle: 'Laporan',
      breadcrumb: [
        {
          text: 'Transaksi',
          active: true,
        },
      ],
    },
  },
  {
    path: '/laporan/cabang',
    name: 'laporan-cabang',
    component: () => import('@/views/laporan/cabang/Laporan.vue'),
    meta: {
      resource: 'laporan_cabang',
      pageTitle: 'Laporan',
      breadcrumb: [
        {
          text: 'Cabang',
        },
      ],
    },
  },
  {
    path: '/laporan/kasir',
    name: 'laporan-kasir',
    component: () => import('@/views/laporan/kasir/Laporan.vue'),
    meta: {
      resource: 'laporan_kasir',
      pageTitle: 'Laporan',
      breadcrumb: [
        {
          text: 'Kasir',
        },
      ],
    },
  },
]
