<template>
  <before-login-form-card>
    <template #form-card-content>
      <v-form
        ref="form"
        v-model="isValid"
      >
        <user-form-email 
          :email.sync="params.email"
          no-validation
        />
        <user-form-password 
          :password.sync="params.password"
          no-validation
        />
        <v-card-actions>
          <nuxt-link
            to="#"
            class="body-2 text-decoration-none"
        >
          パスワードを忘れた？
          </nuxt-link>
        </v-card-actions>
        <v-card-text class="px-0">
          <div>{{error}}</div>
          <v-btn
            :disabled="!isValid || loading"
            :loading="loading"
            block
            color="light-blue darken-1"
            class="white--text"
            @click="login"
          >
            ログインする
          </v-btn>
        </v-card-text>
      </v-form>
    </template>
  </before-login-form-card>
</template>

<script>
export default {
  layout: 'beforeLogin',
  auth: false,
  data () {
    return {
      isValid: false,
      loading: false,
      params: { email: '', password: '' }, 
      error: null
    }
  },
  methods: {
    async login () {
      try {
        this.loading = true
        const res = await this.$auth.loginWith('local', { data: this.params })
        .then(
          (res) => {
          this.$store.dispatch('login')
          const user = res.data.data
          const expiry = res.headers.expiry 
          this.$nxauth.setData(user)
          this.$nxauth.setStorage(expiry)
          //vuexにセットされたユーザーデータを出力
          console.log(this.$store.state.current.user.id)
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
        this.error = 'メールアドレス、もしくはパスワードが間違っています。'
        this.formReset()
      }
    },
    formReset () {
      this.$refs.form.reset()
      this.params = { email: '', password: '' }
    }
  },
};
</script>