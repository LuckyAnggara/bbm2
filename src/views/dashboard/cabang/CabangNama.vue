<template>
  <b-card text-variant="center" class="card card-congratulations">
    <b-avatar variant="warning" size="70" class="shadow mb-2">
      <feather-icon size="28" icon="AwardIcon" />
    </b-avatar>
    <h1 class="mb-1 mt-50 text-white">{{ cabang.nama }}</h1>
    <b-card-text class="m-auto w-75">
      {{ cabang.alamat }}<br />
      {{ cabang.nomor_telepon }} <br />
      <span class="mt-2 font-2">{{ $moment().format('DD MMMM YYYY') }}</span>
    </b-card-text>
  </b-card>
</template>

<script>
import {
  BCard,
  // BImg,
  BAvatar,
  BCardText,
} from 'bootstrap-vue'

export default {
  components: {
    BCard,
    BAvatar,
    // BImg,
    BCardText,
  },
  computed: {
    cabang() {
      const user = JSON.parse(localStorage.getItem('userData'))
      return user.cabang
    },
  },
}
</script>
