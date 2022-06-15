<template>
  <div class="container welcome">
    <p>ポートフォリオサイトへようこそ</p>
    <div v-if="shouldShowLoginForm">
      <LoginForm />
      <p class="change-form">初めての方は<span @click="shouldShowLoginForm = false">こちら</span>をクリック</p>
    </div>
    <div v-if="!shouldShowLoginForm">
      <SignupForm />
      <p class="change-form">アカウントをお持ちの方は<span @click="shouldShowLoginForm = true">こちら</span>をクリック</p>
    </div>
  </div>
  <!--
  <div>
    <button
      type="button"
      name="button"
      @click="getMsg"
    >
      click here
    </button>
    <div
      v-for="(msg, i) in msgs"
      :key="i"
    >
      {{ msg }}
    </div>
  </div>
  -->
</template>

<script>
import LoginForm from '~/components/FormComponents/LoginForm.vue'
import SignupForm from "~/components/FormComponents/SignupForm.vue"
export default {
  layout ({ store }) {
    return store.state.loggedIn ? 'default' : 'welcome'
  },
  components: { SignupForm, LoginForm },
  data () {
    return {
      shouldShowLoginForm: true
    }
  }
};
/*
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
*/
</script>