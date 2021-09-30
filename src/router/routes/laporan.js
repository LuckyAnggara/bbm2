export default [
  {
    path: '/laporan/persediaan/',
    name: 'laporan-persediaan',
    component: () => import('@/views/laporan/persediaan/Master.vue'),
    meta: {
      resource: 'laporan-persediaan',
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
      resource: 'laporan-transaksi',
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
    path: '/laporan/cabang/performance',
    name: 'laporan-cabang-performance',
    component: () => import('@/views/laporan/cabang/Performance.vue'),
    meta: {
      resource: 'laporan-cabang-performance',
      pageTitle: 'Laporan',
      breadcrumb: [
        {
          text: 'Cabang',
        },
        {
          text: 'Performance',
          active: true,
        },
      ],
    },
  },
]
