export default [
  {
    header: 'Keuangan',
  },
  {
    title: 'Beban',
    icon: 'HomeIcon',
    tagVariant: 'light-warning',
    children: [
      {
        title: 'Operasional',
        route: 'beban-operasional-daftar',
      },
      {
        title: 'Gaji',
        route: 'beban-gaji-daftar',
      },
    ],
  },
  {
    title: 'Akuntansi',
    icon: 'HomeIcon',
    tagVariant: 'light-warning',
    children: [
      {
        title: 'Daftar Akun',
        route: 'akuntansi-akun-daftar',
      },
      {
        title: 'Jurnal',
        route: 'akuntansi-jurnal-daftar',
      },
      {
        title: 'Neraca',
        route: 'akuntansi-neraca',
      },
      {
        title: 'Laba / Rugi',
        route: 'akuntansi-laba-rugi',
      },
    ],
  },
  {
    title: 'Kas',
    icon: 'HomeIcon',
    tagVariant: 'light-warning',
    children: [
      {
        title: 'Kasir',
        route: 'kas-kasir',
      },
    ],
  },
]
