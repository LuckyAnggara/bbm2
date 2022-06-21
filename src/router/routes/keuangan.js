export default [
  {
    path: '/akuntansi/akun/daftar',
    name: 'akuntansi-akun-daftar',
    component: () => import('@/views/keuangan/akuntansi/akun/Daftar.vue'),
    meta: {
      resource: 'keuangan_akuntansi_daftar',
      pageTitle: 'Akun',
      breadcrumb: [
        {
          text: 'Daftar',
          active: true,
        },
      ],
    },
  },
  {
    path: '/akuntansi/jurnal/daftar',
    name: 'akuntansi-jurnal-daftar',
    component: () => import('@/views/keuangan/akuntansi/jurnal/Daftar.vue'),
    meta: {
      resource: 'keuangan_akuntansi_jurnal',
      pageTitle: 'Jurnal',
      breadcrumb: [
        {
          text: 'Daftar',
          active: true,
        },
      ],
    },
  },
  {
    path: '/akuntansi/jurnal/tambah',
    name: 'akuntansi-jurnal-tambah',
    component: () => import('@/views/keuangan/akuntansi/jurnal/Tambah.vue'),
    meta: {
      resource: 'keuangan_akuntansi_jurnal',
      pageTitle: 'Jurnal',
      breadcrumb: [
        {
          text: 'Daftar',
          active: true,
        },
      ],
    },
  },
  {
    path: '/akuntansi/jurnal/detail/:id',
    name: 'akuntansi-jurnal-detail',
    component: () => import('@/views/keuangan/akuntansi/jurnal/Detail.vue'),
    meta: {
      resource: 'keuangan_akuntansi',
      pageTitle: 'Jurnal',
      breadcrumb: [
        {
          text: 'Detail',
          active: true,
        },
      ],
    },
  },
  // {
  //   path: '/akuntansi/ledger/daftar',
  //   name: 'akuntansi-ledger-daftar',
  //   component: () => import('@/views/keuangan/akuntansi/jurnal/Daftar.vue'),
  //   meta: {
  //     resource: 'keuangan_akuntansi',
  //     pageTitle: 'Ledger',
  //     breadcrumb: [
  //       {
  //         text: 'Daftar',
  //         active: true,
  //       },
  //     ],
  //   },
  // },
  {
    path: '/akuntansi/ledger/detail/:id',
    name: 'akuntansi-ledger-detail',
    component: () => import('@/views/keuangan/akuntansi/ledger/Detail.vue'),
    meta: {
      resource: 'keuangan_akuntansi',
      pageTitle: 'Ledger',
      breadcrumb: [
        {
          text: 'Daftar',
          to: '/akuntansi/jurnal/daftar/',
        },
        {
          text: 'Detail',
          active: true,
        },
      ],
    },
  },
  {
    path: '/akuntansi/neraca/',
    name: 'akuntansi-neraca',
    component: () => import('@/views/keuangan/akuntansi/neraca/Detail.vue'),
    meta: {
      resource: 'keuangan_akuntansi_neraca',
      pageTitle: 'Neraca',
    },
  },
  {
    path: '/akuntansi/laba-rugi/',
    name: 'akuntansi-laba-rugi',
    component: () => import('@/views/keuangan/akuntansi/laba-rugi/Detail.vue'),
    meta: {
      resource: 'keuangan_akuntansi_laba_rugi',
      pageTitle: 'Laba Rugi',
    },
  },
  {
    path: '/beban/operasional/',
    name: 'beban-operasional-daftar',
    component: () => import('@/views/keuangan/beban/operasional/Daftar.vue'),
    meta: {
      resource: 'keuangan_beban',
      pageTitle: 'Operasional',
      breadcrumb: [
        {
          text: 'Daftar',
          active: true,
        },
      ],
    },
  },
  {
    path: '/beban/gaji/daftar',
    name: 'beban-gaji-daftar',
    component: () => import('@/views/keuangan/beban/gaji/Daftar.vue'),
    meta: {
      resource: 'keuangan_beban',
      pageTitle: 'Gaji',
      breadcrumb: [
        {
          text: 'Daftar',
          active: true,
        },
      ],
    },
  },
  {
    path: '/beban/gaji/tambah/detail',
    name: 'beban-gaji-tambah-detail',
    component: () => import('@/views/keuangan/beban/gaji/tambah/Detail.vue'),
    meta: {
      resource: 'keuangan_beban',
      pageTitle: 'Gaji',
      breadcrumb: [
        {
          text: 'Daftar',
          to: '/beban/gaji/daftar',
        },
        {
          text: 'Detail Penggajian',
          active: true,
        },
      ],
    },
  },
  {
    path: '/kas/daftar/',
    name: 'kas-daftar',
    component: () => import('@/views/keuangan/kas/Daftar.vue'),
    meta: {
      resource: 'keuangan_kas',
      pageTitle: 'Daftar Kas',
      breadcrumb: [
        {
          text: 'Daftar',
          active: true,
        },
      ],
    },
  },
  {
    path: '/kas/kasir/',
    name: 'kas-kasir',
    component: () => import('@/views/keuangan/kas/Kasir.vue'),
    meta: {
      resource: 'keuangan_kas',
      pageTitle: 'Kas Kasir',
      breadcrumb: [
        {
          text: 'Daftar',
          to: '/kas/daftar/',
        },
        {
          text: 'Kasir',
          active: true,
        },
      ],
    },
  },
  {
    path: '/kas/cabang/',
    name: 'kas-cabang',
    component: () => import('@/views/keuangan/kas/Cabang.vue'),
    meta: {
      resource: 'keuangan_kas',
      pageTitle: 'Kas',
      breadcrumb: [
        {
          text: 'Daftar',
          to: '/kas/daftar/',
        },
        {
          text: 'Cabang',
          active: true,
        },
      ],
    },
  },
  {
    path: '/kas/bank/',
    name: 'kas-bank',
    component: () => import('@/views/keuangan/kas/Bank.vue'),
    meta: {
      resource: 'keuangan_kas',
      pageTitle: 'Kas',
      breadcrumb: [
        {
          text: 'Daftar',
          to: '/kas/daftar/',
        },
        {
          text: 'Bank',
          active: true,
        },
      ],
    },
  },
  {
    path: '/keuangan/utangpiutang/',
    name: 'keuangan-utang-piutang',
    component: () => import('@/views/keuangan/utang-piutang/UtangPiutang.vue'),
    meta: {
      resource: 'keuangan_utang_piutang',
      pageTitle: 'Keuangan',
      breadcrumb: [
        {
          text: 'Utang / Piutang',
          active: true,
        },
      ],
    },
  },
  {
    path: '/keuangan/utangpiutang/bulkpembayaranutang',
    name: 'keuangan-bulk-pembayaran-utang',
    component: () => import('@/views/keuangan/utang-piutang/BulkPembayaranUtang.vue'),
    meta: {
      resource: 'keuangan_utang_piutang',
      pageTitle: 'Keuangan',
      breadcrumb: [
        {
          text: 'Utang / Piutang',
          to: '/keuangan/utangpiutang/',
        },
        {
          text: 'Bulk Pembayaran Utang',
          active: true,
        },
      ],
    },
  },
  {
    path: '/keuangan/utangpiutang/bulkpembayaranpiutang',
    name: 'keuangan-bulk-pembayaran-piutang',
    component: () => import('@/views/keuangan/utang-piutang/BulkPembayaranPiutang.vue'),
    meta: {
      resource: 'keuangan_utang_piutang',
      pageTitle: 'Keuangan',
      breadcrumb: [
        {
          text: 'Utang / Piutang',
          to: '/keuangan/utangpiutang/',
        },
        {
          text: 'Bulk Pembayaran Piutang',
          active: true,
        },
      ],
    },
  },
  {
    path: '/keuangan/utangpiutang/pembayaranpo',
    name: 'keuangan-bulk-pembayaran-utang-po',
    component: () => import('@/views/keuangan/utang-piutang/PembayaranPo.vue'),
    meta: {
      resource: 'keuangan_utang_piutang',
      pageTitle: 'Keuangan',
      breadcrumb: [
        {
          text: 'Utang / Piutang',
          to: '/keuangan/utangpiutang/',
        },
        {
          text: 'Pembayaran Utang PO',
          active: true,
        },
      ],
    },
  },
]
