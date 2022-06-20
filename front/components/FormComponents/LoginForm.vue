<template>
  <v-form>
    <v-card width="400px">
      <!-- タイトル -->
      <v-card-title class="headline">ログイン</v-card-title>
 
      <!-- 入力欄 -->
      <v-card-text>
        <EmailField :email.sync="email" />
        <PasswordField :password.sync="password" />
      </v-card-text>
 
      <!-- アクションボタン -->
      <v-card-actions>
        <v-btn @click="loginWithAuthModule">ログイン</v-btn>
      </v-card-actions>
    </v-card>
  </v-form>
</template>
 
<script>
import EmailField from "~/components/user/userFormEmail.vue";
import PasswordField from "~/components/user/userFormPassword.vue";
export default {
  components: { EmailField, PasswordField },
  auth: false,
  data() {
    return {
      email: "",
      password: "",
    };
  },
  methods: {
    async loginWithAuthModule() {
      await this.$auth
        .loginWith('local', {
          data: {
            email: this.email,
            password: this.password,
          },
        })
        .then(
          (response) => {
            // レスポンスで返ってきた、認証に必要な情報をlocalStorageに保存
            localStorage.setItem('access-token', response.headers['access-token'])
            localStorage.setItem('client', response.headers.client)
            localStorage.setItem('uid', response.headers.uid)
            localStorage.setItem('token-type', response.headers['token-type'])
            return response
          },
          (error) => {
            return error
          }
        )
    },
  },
}
</script>