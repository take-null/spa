<template>
  <div>
    <button
      type="button"
      name="button"
      @click="getMsg"
    >
      hello
    </button>
    <div
      v-for="(msg, i) in msgs"
      :key="i"
    >
      {{ msg }}
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      msgs: []
    }
  },
  methods: {
    getMsg () {
      //本番用
      //this.$axios.$get('https://referer-hub-api.net')
      //開発用(railsのトップページを取得して配列に格納し、出力)
      this.$axios.$get('/')
        .then(res => this.msgs.push(res))
    }
  }
}
</script>