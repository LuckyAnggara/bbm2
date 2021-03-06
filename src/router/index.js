import Vue from 'vue'
import VueRouter from 'vue-router'

// Routes
import { canNavigate } from '@/libs/acl/routeProtection'
import { isUserLoggedIn, getUserData, getHomeRouteForLoggedInUser } from '@/auth/utils'
import dashboard from './routes/dashboard'
import keuangan from './routes/keuangan'
import transaksi from './routes/transaksi'
import auth from './routes/auth'
import master from './routes/master'
import laporan from './routes/laporan'
import kepegawaian from './routes/kepegawaian'

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  scrollBehavior() {
    return { x: 0, y: 0 }
  },
  routes: [
    { path: '/', redirect: { name: 'dashboard-cabang' } },
    ...auth,
    ...master,
    ...transaksi,
    ...keuangan,
    ...dashboard,
    ...laporan,
    ...kepegawaian,
    {
      path: '*',
      redirect: 'auth-not-authorized',
    },
  ],
})
/* eslint-disable */
router.beforeEach((to, _, next) => {
  const isLoggedIn = isUserLoggedIn()

  if (!canNavigate(to)) {
    // Redirect to login if not logged in
    if (!isLoggedIn) return next({ name: 'auth-login' })
    // If logged in => not authorized
    return next({ name: 'auth-not-authorized' })
  }

  // // Redirect if logged in
  if (to.meta.redirectIfLoggedIn && isLoggedIn) {
    const userData = getUserData()

    next(getHomeRouteForLoggedInUser(userData ? userData.role.nama : null))
  }

  return next()
})

export default router
