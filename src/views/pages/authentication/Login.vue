<template>
  <div class="auth-wrapper auth-v2" ref="loginDiv">
    <b-row class="auth-inner m-0">
      <!-- Brand logo-->
      <b-link class="brand-logo">
        <vuexy-logo />
        <h2 class="brand-text text-primary ml-1">
          SIAP-BBM
        </h2>
      </b-link>
      <!-- /Brand logo-->

      <!-- Left Text-->
      <b-col lg="8" class="d-none d-lg-flex align-items-center p-5">
        <div class="w-100 d-lg-flex align-items-center justify-content-center px-5">
          <b-img fluid :src="imgUrl" alt="Login V2" />
        </div>
      </b-col>
      <!-- /Left Text-->

      <!-- Login-->
      <b-col lg="4" class="d-flex align-items-center auth-bg px-2 p-lg-5">
        <b-col sm="8" md="6" lg="12" class="px-xl-2 mx-auto">
          <b-card-title title-tag="h2" class="font-weight-bold mb-1">
            Welcome to SIAP-BBM! 👋
          </b-card-title>
          <b-card-text class="mb-2">
            Mohon sign-in untuk memulai aktifitas mu
          </b-card-text>

          <!-- form -->
          <b-form class="auth-login-form mt-2" @submit.prevent>
            <!-- email -->
            <b-form-group label="Username" label-for="login-email">
              <b-form-input id="login-email" v-model="form.username" name="login-email" placeholder="john@example.com" />
            </b-form-group>

            <!-- forgot password -->
            <b-form-group>
              <div class="d-flex justify-content-between">
                <label for="login-password">Password</label>
                <b-link :to="{ name: '/' }">
                  <small>Lupa Password?</small>
                </b-link>
              </div>
              <b-input-group class="input-group-merge">
                <b-form-input id="login-password" v-model="form.password" class="form-control-merge" name="login-password" placeholder="············" />
                <b-input-group-append is-text>
                  <feather-icon class="cursor-pointer" :icon="passwordToggleIcon" @click="togglePasswordVisibility" />
                </b-input-group-append>
              </b-input-group>
            </b-form-group>

            <!-- checkbox -->
            <b-form-group>
              <b-form-checkbox id="remember-me" v-model="form.status" name="checkbox-1">
                Ingat saya
              </b-form-checkbox>
            </b-form-group>

            <!-- submit buttons -->
            <b-button type="submit" variant="primary" block @click="login">
              Sign in
            </b-button>
          </b-form>

          <b-card-text class="text-center mt-2">
            <span>User baru? </span>
            <span class="text-primary">&nbsp;Hubungi admin untuk membuat user</span>
          </b-card-text>
        </b-col>
      </b-col>
      <!-- /Login-->
    </b-row>
  </div>
</template>

<script>
/* eslint-disable global-require */
import axios from '@axios'
// import { getHomeRouteForLoggedInUser } from '@/auth/utils'
import { togglePasswordVisibility } from '@core/mixins/ui/forms'

import VuexyLogo from '@core/layouts/components/Logo.vue'
import {
  BRow,
  BCol,
  BLink,
  BFormGroup,
  BFormInput,
  BInputGroupAppend,
  BInputGroup,
  BFormCheckbox,
  BCardText,
  BCardTitle,
  BImg,
  BForm,
  BButton,
} from 'bootstrap-vue'
import { required } from '@validations'
import store from '@/store/index'
import ToastificationContent from '@core/components/toastification/ToastificationContent.vue'

export default {
  components: {
    BRow,
    BCol,
    BLink,
    BFormGroup,
    BFormInput,
    BInputGroupAppend,
    BInputGroup,
    BFormCheckbox,
    BCardText,
    BCardTitle,
    BImg,
    BForm,
    BButton,
    VuexyLogo,
  },
  mixins: [togglePasswordVisibility],
  data() {
    return {
      form: {
        password: '',
        username: '',
      },
      sideImg: require('@/assets/images/pages/login-v2.svg'),
      // validation rulesimport store from '@/store/index'
      required,
    }
  },
  computed: {
    passwordToggleIcon() {
      return this.passwordFieldType === 'password' ? 'EyeIcon' : 'EyeOffIcon'
    },
    imgUrl() {
      if (store.state.appConfig.layout.skin === 'dark') {
        // eslint-disable-next-line vue/no-side-effects-in-computed-properties
        this.sideImg = require('@/assets/images/pages/login-v2-dark.svg')
        return this.sideImg
      }
      return this.sideImg
    },
  },
  created() {
    console.info(this.$router.currentRoute)
  },
  methods: {
    login() {
      const loader = this.$loading.show({
        // Optional parameters
        container: this.$refs.loginDiv,
      })
      const data = this.form
      axios.post(`${axios.defaults.baseURL}auth/login`, data).then(res => {
        if (res.status === 201 || res.status === 202 || res.status === 203) {
          this.$toast({
            component: ToastificationContent,
            props: {
              title: res.data,
              icon: 'UserXIcon',
              variant: 'danger',
            },
          })
        } else {
          const userData = res.data
          localStorage.setItem('userData', JSON.stringify(res.data))
          this.$ability.update(userData.ability)
          console.info(this.$ability)
          console.info(userData)
          // this.$router
          //   .replace('/')
          //   .then(() => {
          //     this.$toast({
          //       component: ToastificationContent,
          //       position: 'top-right',
          //       props: {
          //         title: `Welcome ${userData.fullName || userData.username}`,
          //         icon: 'CoffeeIcon',
          //         variant: 'success',
          //         text: `You have successfully logged in as ${userData.role}. Now you can start to explore!`,
          //       },
          //     })
          //   })
          //   .catch(error => {
          //     this.$refs.loginForm.setErrors(error.res.data.error)
          //   })
        }
        loader.hide()
      })
    },
  },
}
</script>

<style lang="scss">
@import '@core/scss/vue/pages/page-auth.scss';
@import '@core/scss/vue/libs/vue-flatpicker.scss';
</style>
