export default [
  {
    path: '/kepegawaian/daftar',
    name: 'kepegawaian-daftar',
    component: () => import('@/views/kepegawaian/Daftar.vue'),
    meta: {
      resource: 'admin',
      pageTitle: 'Pegawai',
      breadcrumb: [
        {
          text: 'Daftar',
          active: true,
        },
      ],
    },
  },
  {
    path: '/kepegawaian/tambah',
    name: 'kepegawaian-tambah',
    component: () => import('@/views/kepegawaian/Tambah.vue'),
    meta: {
      resource: 'ACL',
      pageTitle: 'Pegawai',
      breadcrumb: [
        {
          text: 'Tambah',
          active: true,
        },
      ],
    },
  },
  {
    path: '/kepegawaian/detail/:id',
    name: 'kepegawaian-detail',
    component: () => import('@/views/kepegawaian/Detail.vue'),
    meta: {
      resource: 'ACL',
      pageTitle: 'Pegawai',
      breadcrumb: [
        {
          text: 'Daftar',
          to: '/kepegawaian/daftar/',
        },
        {
          text: 'Detail',
          active: true,
        },
      ],
    },
  },
  {
    path: '/kepegawaian/presensi/',
    name: 'master-presensi',
    component: () => import('@/views/kepegawaian/presensi/Daftar.vue'),
    meta: {
      resource: 'ACL',
      pageTitle: 'Presensi Pegawai',
      breadcrumb: [
        {
          text: 'Daftar',
          to: '/kepegawaian/presensi/',
        },
      ],
    },
  },
  {
    path: '/kepegawaian/presensi/tambah/manual',
    name: 'master-presensi-tambah-manual',
    component: () => import('@/views/kepegawaian/presensi/TambahManual.vue'),
    meta: {
      resource: 'ACL',
      pageTitle: 'Presensi Pegawai',
      breadcrumb: [
        {
          text: 'Daftar',
          to: '/kepegawaian/presensi/',
        },
        {
          text: 'Tambah Data',
          active: true,
        },
      ],
    },
  },
  {
    path: '/kepegawaian/presensi/tambah/bulk',
    name: 'master-presensi-tambah-bulk',
    component: () => import('@/views/kepegawaian/presensi/TambahBulk.vue'),
    meta: {
      resource: 'ACL',
      pageTitle: 'Presensi Pegawai',
      breadcrumb: [
        {
          text: 'Daftar',
          to: '/kepegawaian/presensi/',
        },
        {
          text: 'Tambah Data',
          active: true,
        },
      ],
    },
  },
  {
    path: '/kepegawaian/presensi/upload',
    name: 'master-presensi-upload',
    component: () => import('@/views/kepegawaian/presensi/Upload.vue'),
    meta: {
      resource: 'ACL',
      pageTitle: 'Presensi Pegawai',
      breadcrumb: [
        {
          text: 'Daftar',
          to: '/kepegawaian/daftar/',
        },
        {
          text: 'Upload Data',
          active: true,
        },
      ],
    },
  },
]
