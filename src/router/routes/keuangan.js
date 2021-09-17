export default [
  {
    path: '/akuntansi/akun/daftar',
    name: 'akuntansi-akun-daftar',
    component: () => import('@/views/keuangan/akuntansi/akun/Daftar.vue'),
    meta: {
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
      pageTitle: 'Jurnal',
      breadcrumb: [
        {
          text: 'Detail',
          active: true,
        },
      ],
    },
  },
  {
    path: '/akuntansi/ledger/daftar',
    name: 'akuntansi-ledger-daftar',
    component: () => import('@/views/keuangan/akuntansi/jurnal/Daftar.vue'),
    meta: {
      resource: 'ACL',
      pageTitle: 'Ledger',
      breadcrumb: [
        {
          text: 'Daftar',
          active: true,
        },
      ],
    },
  },
  {
    path: '/akuntansi/ledger/detail/:id',
    name: 'akuntansi-ledger-detail',
    component: () => import('@/views/keuangan/akuntansi/ledger/Detail.vue'),
    meta: {
      pageTitle: 'Ledger',
      breadcrumb: [
        {
          text: 'Daftar',
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
      pageTitle: 'Neraca',
    },
  },
  {
    path: '/akuntansi/laba-rugi/',
    name: 'akuntansi-laba-rugi',
    component: () => import('@/views/keuangan/akuntansi/laba-rugi/Detail.vue'),
    meta: {
      pageTitle: 'Laba Rugi',
    },
  },
  {
    path: '/beban/operasional/',
    name: 'beban-operasional-daftar',
    component: () => import('@/views/keuangan/beban/operasional/Daftar.vue'),
    meta: {
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
    path: '/beban/gaji/',
    name: 'beban-gaji-daftar',
    component: () => import('@/views/keuangan/beban/gaji/Daftar.vue'),
    meta: {
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
      pageTitle: 'Gaji',
      breadcrumb: [
        {
          text: 'Daftar',
        },
        {
          text: 'Detail Penggajian',
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
      pageTitle: 'Kas Kasir',
      breadcrumb: [
        {
          text: 'Detail',
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
      pageTitle: 'Kas Cabang',
      breadcrumb: [
        {
          text: 'Detail',
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
]
