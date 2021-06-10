export default [
  {
    path: '/kepegawaian/daftar',
    name: 'kepegawaian-daftar',
    component: () => import('@/views/kepegawaian/Daftar.vue'),
    meta: {
      resource: 'ACL',
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
]
