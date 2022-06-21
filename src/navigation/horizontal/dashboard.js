export default [
  {
    title: 'Dashboards',
    icon: 'HomeIcon',
    tag: '2',
    tagVariant: 'light-warning',
    children: [
      {
        title: 'Cabang',
        route: 'dashboard-cabang',
        icon: 'ActivityIcon',
        resource: 'dashboard_cabang',
      },
      {
        title: 'Kasir',
        route: 'dashboard-kasir',
        icon: 'ActivityIcon',
        resource: 'dashboard_kasir',
      },
    ],
  },
  {
    title: 'Laporan',
    route: 'auth-login-new',
    icon: 'ShieldIcon',
    children: [
      {
        title: 'Persediaan',
        route: 'laporan-persediaan',
        resource: 'laporan_persediaan',
      },
      {
        title: 'Kasir',
        route: 'laporan-kasir',
        resource: 'laporan_kasir',
      },
      {
        title: 'Cabang',
        children: [
          {
            title: 'Performance',
            route: 'laporan-cabang-performance',
            resource: 'laporan_cabang',
          },
        ],
      },
      {
        title: 'Sales',
        route: 'laporan-sales',
        resource: 'laporan_sales',
      },

      {
        title: 'Transaksi',
        route: 'laporan-transaksi',
        resource: 'laporan_transaksi',
      },
      {
        title: 'Keuangan',
        children: [
          {
            title: 'Neraca',
            route: 'laporan-neraca',
            resource: 'laporan_neraca',
          },
          {
            title: 'Laba / Rugi',
            route: 'laporan-laba-rugi',
            resource: 'laporan_laba_rugi',
          },
        ],
      },
    ],
  },
]
