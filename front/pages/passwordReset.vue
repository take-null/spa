<template>
  <before-login-form-card>
    <template #form-card-content>
      <v-form ref="form" v-model="isValid">
        <user-form-password :password.sync="params.password" />
        <user-frorm-password-confirmation
          :password_confirmation.sync="params.password_confirmation"
        />
        <v-card-text class="px-0">
          <div>
            {{ error }}
          </div>
          <v-btn
            :disabled="!isValid || loading"
            :loading="loading"
            block
            dark
            class="white--text"
            @click="change"
          >
            再設定する
          </v-btn>
        </v-card-text>
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
      params: { password: '', password_confirmation: '' },
      error: null,
    }
  },
  mounted() {
    localStorage.setItem('access-token', this.$route.query['access-token'])
    localStorage.setItem('client', this.$route.query.client)
    localStorage.setItem('uid', this.$route.query.uid)
  },
  methods: {
    async change() {
      try {
        this.loading = true
        const formData = new FormData()
        formData.append('password', this.params.password)
        formData.append(
          'password_confirmation',
          this.params.password_confirmation
        )
        await this.$axios
          .put('/api/v1/auth/password', formData, {
            'content-type': 'multipart/form-data',
          })
          .then((res) => {
            this.loading = false
            this.$router.replace('/')
            return res
          })
      } catch (error) {
        console.log({ error })
        this.loading = false
        this.error = 'パスワードの不一致、または入力内容が間違っています。'
        this.formReset()
      }
    },
    formReset() {
      this.$refs.form.reset()
      this.params = { password: '', password_confirmation: '' }
    },
  },
}
</script>
