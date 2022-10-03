<template>
  <before-login-form-card>
    <template #form-card-content>
      <v-form ref="form" v-model="isValid">
        <user-form-name :name.sync="params.name" />
        <user-form-email :email.sync="params.email" />
        <user-form-password :password.sync="params.password" />
        <user-frorm-password-confirmation
          :password_confirmation.sync="params.password_confirmation"
        />
        <div>{{ error }}</div>
        <v-btn
          :disabled="!isValid || loading"
          :loading="loading"
          block
          dark
          class="white--text"
          @click.prevent="signup"
        >
          登録する
        </v-btn>
      </v-form>
    </template>
  </before-login-form-card>
</template>

<script>
export default {
  layout: 'beforeLogin',
  data() {
    return {
      isValid: false,
      loading: false,
      params: { name: '', email: '', password: '', password_confirmation: '' },
      error: null,
    }
  },
  methods: {
    async signup() {
      try {
        this.loading = true
        const res = await this.$axios
          .post('/api/v1/auth', this.params)
          .then((res) => {
            this.$store.dispatch('login')
            const user = res.data.data
            const expiry = res.headers.expiry
            this.$nxauth.setData(user)
            this.$nxauth.setStorage(expiry)
            this.notification()
            this.loading = false
            this.$router.replace('/')
            return res
          })
      } catch (error) {
        console.log({ error })
        this.loading = false
        this.error = '登録に失敗しました。'
        this.formReset()
      }
    },
    formReset() {
      this.$refs.form.reset()
      this.params = {
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
      }
    },
    async notification() {
      await this.$axios
        .$get(
          `/api/v1/users/search?email=${window.localStorage.getItem('uid')}`
        )
        .then((res) => {
          const user = res
          this.$store
            .dispatch('getCurrentUser', user)
            .catch(() => this.$nxauth.removeStorage())
        })
    },
  },
}
</script>
