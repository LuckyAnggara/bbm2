<template>
  <section>
    <b-card class="earnings-card">
      <b-row>
        <b-col cols="6">
          <div class="font-small-2">
            {{ subTitle }}
          </div>
          <h3 class="font-weight-bolder mb-25">
            {{ statistic }}
          </h3>
          <b-card-text class="font-weight-bold mb-2">
            {{ label }}
          </b-card-text>
        </b-col>
        <b-col cols="6" class="text-right mt-2">
          <b-button v-ripple.400="'rgba(255, 255, 255, 0.15)'" variant="primary" class="shadow" @click="$router.push(route)">
            <span>Lebih Lanjut </span>
            <feather-icon icon="ChevronsRightIcon" />
          </b-button>
        </b-col>
      </b-row>
    </b-card>
  </section>
</template>

<script>
import {
  // BButtonGroup,
  BButton,
  BCard,
  BCardText,
  BRow,
  BCol,
} from 'bootstrap-vue'
import Ripple from 'vue-ripple-directive'

export default {
  components: {
    // BButtonGroup,
    BButton,
    BCard,
    BCardText,
    BRow,
    BCol,
  },
  directives: {
    Ripple,
  },
  props: {
    statistic: {
      type: String,
      default: null,
    },
    label: {
      type: String,
      default: null,
    },
    subTitle: {
      type: String,
      default: null,
    },
    route: {
      type: Object,
      default: null,
    },
  },
}
</script>
