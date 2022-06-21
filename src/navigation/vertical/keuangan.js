export default [
  {
    header: 'Keuangan',
    resource: 'header',
  },
  {
    title: 'Beban',
    icon: 'HomeIcon',
    resource: 'keuangan_beban',
    children: [
      {
        title: 'Operasional',
        route: 'beban-operasional-daftar',
        resource: 'keuangan_beban',
      },
      {
        title: 'Gaji',
        route: 'beban-gaji-daftar',
        resource: 'keuangan_beban',
      },
    ],
  },
  {
    title: 'Akuntansi',
    icon: 'HomeIcon',
    resource: 'keuangan_akuntansi',
    children: [
      {
        title: 'Daftar Akun',
        route: 'akuntansi-akun-daftar',
        resource: 'keuangan_akuntansi_daftar',
      },
      {
        title: 'Jurnal',
        route: 'akuntansi-jurnal-daftar',
        resource: 'keuangan_akuntansi_jurnal',
      },
      {
        title: 'Neraca',
        route: 'akuntansi-neraca',
        resource: 'keuangan_akuntansi_neraca',
      },
      {
        title: 'Laba / Rugi',
        route: 'akuntansi-laba-rugi',
        resource: 'keuangan_akuntansi_laba_rugi',
      },
    ],
  },
  {
    title: 'Kas',
    icon: 'HomeIcon',
    resource: 'keuangan_kas',
    children: [
      {
        title: 'Daftar',
        route: 'kas-daftar',
        resource: 'keuangan_kas',
      },
      {
        title: 'Cabang',
        route: 'kas-cabang',
        resource: 'keuangan_kas',
      },
      {
        title: 'Kasir',
        route: 'kas-kasir',
        resource: 'keuangan_kas',
      },
      {
        title: 'Bank',
        route: 'kas-bank',
        resource: 'keuangan_kas',
      },
    ],
  },
  {
    title: 'Utang / Piutang',
    icon: 'HomeIcon',
    resource: 'keuangan_utang_piutang',
    route: 'keuangan-utang-piutang',
  },
]
