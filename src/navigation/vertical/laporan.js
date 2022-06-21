export default [
  {
    title: 'Laporan',
    route: 'auth-login-new',
    icon: 'ShieldIcon',
    children: [
      {
        title: 'Persediaan',
        route: 'master-persediaan',
        resource: 'laporan_persediaan',
      },
      {
        title: 'Kasir',
        route: 'laporan-kasir',
        resource: 'laporan_kasir',
      },
      {
        title: 'Cabang',
        route: 'laporan-cabang',
        resource: 'laporan_cabang',
      },
      {
        title: 'Sales',
        // route: 'laporan-sales',
        resource: 'manajer',
      },

      {
        title: 'Transaksi',
        // route: 'laporan-transaksi',
        resource: 'manajer',
      },
      {
        title: 'Keuangan',
        children: [
          {
            title: 'Neraca',
            // route: 'laporan-neraca',
            resource: 'laporan_neraca',
          },
          {
            title: 'Laba / Rugi',
            // route: 'laporan-laba-rugi',
            resource: 'laporan_laba_rugi',
          },
        ],
      },
    ],
  },
]
