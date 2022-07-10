<template>
  <v-alert
    type="success"
    :value="alert"
    dense
    class="alert"
  >
    <p class="font-italic">{{name}}のフォローを解除しました</p>
  </v-alert>
</template>
<script>
export default {
  props: {
    name: {
      type: String
    }
  },
  data () {
    return {
      alert: true
    }
  },
  created () {
    setTimeout(() => {
      this.alert = false
    }, 1500)
  }
}
</script>