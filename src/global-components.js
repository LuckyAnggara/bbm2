import Vue from 'vue'
import FeatherIcon from '@core/components/feather-icon/FeatherIcon.vue'
import Loading from 'vue-loading-overlay'
import VueMoment from 'vue-moment'

Vue.use(Loading, {
  // props
  canCancel: true,
  color: '#000000',
  loader: 'dots',
  width: 64,
  height: 64,
  backgroundColor: '#ffffff',
  opacity: 0.4,
  zIndex: 999,
  lockScroll: true,
  enforceFocus: true,
  isFullPage: false,
})
Vue.use(VueMoment)
Vue.component(FeatherIcon.name, FeatherIcon)
