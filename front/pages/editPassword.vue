<template>
  <before-login-form-card>
    <template #form-card-content>
      <v-form
        ref="form"
        v-model="isValid"
      >
        <user-form-password 
          :password.sync="params.password"
        />
        <user-frorm-password-confirmation 
          :password_confirmation.sync="params.password_confirmation"
        />
        <v-card-text class="px-0">
          <div>{{error}}</div>
            <v-btn
              :disabled="!isValid || loading"
              :loading="loading"
              block
              dark
              class="white--text"
              @click="change"
              >
                変更する
            </v-btn>
          </v-card-text>
        </v-form>
    </template>
  </before-login-form-card>
</template>

<script>
export default {
  layout ({ $nxauth }) {
    return $nxauth.loggedIn ? 'loggedIn' : 'welcome'
  },
  data () {
    return {
      isValid: false,
      loading: false,
      params: { password: '', password_confirmation: '' }, 
      error: null
    }
  },
  methods: {
    async change () {
      try {
        this.loading = true
        const formData = new FormData()
        formData.append('password', this.params.password)
        formData.append('password_confirmation', this.params.password_confirmation)
        const res = await this.$axios.post('/api/v1/auth/password', formData, {headers: {'content-type': 'multipart/form-data',
                'X-HTTP-Method-Override': 'PUT',}})
        .then(
          (res) => {
          //const user = res.data.data
          //const expiry = res.headers.expiry 
          //this.$nxauth.setData(user)
          //this.$nxauth.setStorage(expiry)
          //vuexにセットされたユーザーデータを出力
          console.log(this.$store.state.current.user)
          this.loading = false
          this.$router.replace('/')
          return res
        }
      )
      //responseを表示
      //console.log({res})
      } catch (error) {
        console.log({error})
        this.loading = false
        this.error = 'パスワードの不一致、または入力内容が間違っています。'
        this.formReset()
      }
    },
    formReset () {
      this.$refs.form.reset()
      this.params = { password: '', password_confirmation: '' }
    }
  },
};
</script>