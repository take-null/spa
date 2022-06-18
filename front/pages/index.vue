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
</template>

<script>
import LoginForm from '~/components/FormComponents/LoginForm.vue'
import SignupForm from "~/components/FormComponents/SignupForm.vue"

export default {
  components: { SignupForm, LoginForm },
  layout ({ store }) {
    return store.state.loggedIn ? 'default' : 'welcome'
  },
  data () {
    return {
      shouldShowLoginForm: true
    }
  },   
};
</script>

