export default [
  {
    path: '/dashboard/analytics',
    name: 'dashboard-analytics',
    meta: {
      resource: 'dashboard-kasir',
    },
    component: () => import('@/views/dashboard/analytics/Analytics.vue'),
  },
  {
    path: '/dashboard/ecommerce',
    name: 'dashboard-ecommerce',
    meta: {
      resource: 'dashboard-kasir',
    },
    component: () => import('@/views/dashboard/ecommerce/Ecommerce.vue'),
  },
]
