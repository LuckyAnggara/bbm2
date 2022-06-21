export default [
  {
    path: '/dashboard/cabang',
    name: 'dashboard-cabang',
    meta: {
      resource: 'dashboard_cabang',
    },
    component: () => import('@/views/dashboard/cabang/Cabang.vue'),
  },
  {
    path: '/dashboard/kasir',
    name: 'dashboard-kasir',
    meta: {
      resource: 'dashboard_kasir',
    },
    component: () => import('@/views/dashboard/kasir/Kasir.vue'),
  },
]
