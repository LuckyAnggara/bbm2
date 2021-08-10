export default [
  {
    title: 'Dashboards',
    icon: 'HomeIcon',
    tag: '2',
    tagVariant: 'light-warning',
    children: [
      {
        title: 'eCommerce',
        route: 'dashboard-ecommerce',
        resource: 'dashboard-kasir',
      },
      {
        title: 'Analytics',
        route: 'dashboard-analytics',
        resource: 'dashboard-kasir',
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
        resource: 'laporan-persediaan',
      },
      {
        title: 'Kasir',
        route: 'laporan-kasir',
        resource: 'kasir',
      },
      {
        title: 'Cabang',
        route: 'laporan-cabang',
      },
      {
        title: 'Sales',
        route: 'laporan-sales',
      },

      {
        title: 'Transaksi',
        route: 'laporan-transaksi',
        resource: 'laporan-transaksi',
      },
      {
        title: 'Keuangan',
        route: 'laporan-keuangan',
        children: [
          {
            title: 'Neraca',
            route: 'laporan-persediaan',
          },
          {
            title: 'Laba / Rugi',
            route: 'laporan-transaksi',
          },
        ],
      },
    ],
  },
  {
    title: 'Login',
    route: 'auth-login-new',
    icon: 'ShieldIcon',
    // },
  },
]
