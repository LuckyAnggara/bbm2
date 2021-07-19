export default [
  {
    path: '/login',
    name: 'auth-login',
    component: () => import('@/views/pages/authentication/Login.vue'),
    meta: {
      layout: 'full',
      resource: 'Auth',
      redirectIfLoggedIn: true,
    },
  },
  {
    path: '/master/barang/tambah',
    name: 'master-barang-tambah',
    component: () => import('@/views/master/barang/Tambah/Tambah.vue'),
    meta: {
      resource: 'ACL',
      pageTitle: 'Tambah',
      breadcrumb: [
        {
          text: 'Barang',
          to: '/master/barang/',
        },
        {
          text: 'Tambah',
          active: true,
        },
      ],
    },
  },
  {
    path: '/master/barang/',
    name: 'master-barang',
    component: () => import('@/views/master/barang/Daftar.vue'),
    meta: {
      resource: 'ACL',
      pageTitle: 'Daftar',
      breadcrumb: [
        {
          active: true,
          text: 'Barang',
          to: '/master/barang/',
        },
      ],
    },
  },
  {
    path: '/master/barang/detail/:id',
    name: 'master-barang-detail',
    component: () => import('@/views/master/barang/Detail/Detail.vue'),
    meta: {
      pageTitle: 'Daftar',
      breadcrumb: [
        {
          text: 'Barang',
          to: '/master/barang/',
        },
        {
          text: 'Detail',
          active: true,
        },
      ],
    },
  },
  {
    path: '/master/kontak/',
    name: 'master-kontak',
    component: () => import('@/views/master/kontak/Daftar.vue'),
    meta: {
      pageTitle: 'Daftar',
      breadcrumb: [
        {
          active: true,
          text: 'Kontak',
          to: '/master/kontak/',
        },
      ],
    },
  },
  {
    path: '/master/kontak/tambah',
    name: 'master-kontak-tambah',
    component: () => import('@/views/master/kontak/Tambah/Tambah.vue'),
    meta: {
      pageTitle: 'Tambah',
      breadcrumb: [
        {
          text: 'Kontak',
          to: '/master/kontak/',
        },
        {
          text: 'Tambah',
          active: true,
        },
      ],
    },
  },
  {
    path: '/master/persediaan/',
    name: 'master-persediaan',
    component: () => import('@/views/master/persediaan/Daftar.vue'),
    meta: {
      pageTitle: 'Daftar',
      breadcrumb: [
        {
          active: true,
          text: 'Persediaan',
          to: '/master/persediaan/',
        },
      ],
    },
  },
  {
    path: '/master/persediaan/transfer',
    name: 'master-persediaan-transfer',
    component: () => import('@/views/master/persediaan/transfer/TransferPersediaan.vue'),
    meta: {
      pageTitle: 'Transfer Persediaan',
      breadcrumb: [
        {
          text: 'Persediaan',
          to: '/master/persediaan/',
        },
        {
          text: 'Transfer',
          active: true,
        },
      ],
    },
  },
  {
    path: '/master/persediaan/transfer/lanjut',
    name: 'master-persediaan-transfer-lanjut',
    component: () => import('@/views/master/persediaan/transfer/TransferPersediaanLanjut.vue'),
    meta: {
      pageTitle: 'Transfer Persediaan Lanjut',
      breadcrumb: [
        {
          text: 'Persediaan',
          to: '/master/persediaan/',
        },
        {
          text: 'Transfer',
          to: '/master/persediaan/transfer',
        },
        {
          text: 'Lanjut',
          active: true,
        },
      ],
    },
  },
  {
    path: '/master/persediaan/transfer/detail/:id',
    name: 'master-persediaan-transfer-detail',
    component: () => import('@/views/master/persediaan/transfer/DetailTransferPersediaan.vue'),
    meta: {
      pageTitle: 'Detail Transfer Persediaan',
      breadcrumb: [
        {
          text: 'Persediaan',
          to: '/master/persediaan/',
        },
        {
          text: 'Transfer',
          to: '/master/persediaan/transfer',
        },
        {
          text: 'Detail',
          active: true,
        },
      ],
    },
  },
  {
    path: '/master/persediaan/penyesuaian',
    name: 'master-persediaan-tambah',
    component: () => import('@/views/master/persediaan/penyesuaian/Penyesuaian.vue'),
    meta: {
      pageTitle: 'Penyesuaian',
      breadcrumb: [
        {
          text: 'Persediaan',
          to: '/master/persediaan/',
        },
        {
          text: 'Penyesuaian',
          active: true,
        },
      ],
    },
  },
  {
    path: '/master/persediaan/penyesuaian',
    name: 'master-persediaan-penyesuaian',
    component: () => import('@/views/master/persediaan/penyesuaian/Penyesuaian.vue'),
    meta: {
      pageTitle: 'Penyesuaian',
      breadcrumb: [
        {
          text: 'Persediaan',
          to: '/master/persediaan/',
        },
        {
          text: 'Penyesuaian',
          active: true,
        },
      ],
    },
  },
  {
    path: '/master/persediaan/penyesuaian/perhitungan-stock',
    name: 'master-persediaan-penyesuaian-perhitungan-stock',
    component: () => import('@/views/master/persediaan/penyesuaian/PerhitunganStock.vue'),
    meta: {
      pageTitle: 'Perhitungan Stock',
      breadcrumb: [
        {
          text: 'Persediaan',
          to: '/master/persediaan/',
        },
        {
          text: 'Penyesuaian',
          to: '/master/persediaan/penyesuaian',
        },
        {
          text: 'Perhitungan Stock',
          active: true,
        },
      ],
    },
  },
  {
    path: '/master/persediaan/penyesuaian/masuk-keluar',
    name: 'master-persediaan-penyesuaian-masuk-keluar',
    component: () => import('@/views/master/persediaan/penyesuaian/MasukKeluar.vue'),
    meta: {
      pageTitle: 'Stok Masuk / Keluar',
      breadcrumb: [
        {
          text: 'Persediaan',
          to: '/master/persediaan/',
        },
        {
          text: 'Penyesuaian',
          to: '/master/persediaan/penyesuaian',
        },
        {
          text: 'Stock Masuk / Keluar',
          active: true,
        },
      ],
    },
  },
  {
    path: '/master/persediaan/penyesuaian/detail/:id',
    name: 'master-persediaan-penyesuaian-detail',
    component: () => import('@/views/master/persediaan/penyesuaian/DetailPenyesuaian.vue'),
    meta: {
      pageTitle: 'Detail',
      breadcrumb: [
        {
          text: 'Persediaan',
          to: '/master/persediaan/',
        },
        {
          text: 'Penyesuaian',
          to: '/master/persediaan/penyesuaian',
        },
        {
          text: 'Detail',
          active: true,
        },
      ],
    },
  },
  {
    path: '/master/persediaan/detail/:id',
    name: 'master-persediaan-detail',
    component: () => import('@/views/master/persediaan/DetailKartuPersediaan.vue'),
    meta: {
      pageTitle: 'Daftar',
      breadcrumb: [
        {
          text: 'Persediaan',
          to: '/master/persediaan/',
        },
        {
          text: 'Detail',
          active: true,
        },
      ],
    },
  },
]
