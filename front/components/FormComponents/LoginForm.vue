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
        <v-btn @click="submit">ログイン</v-btn>
      </v-card-actions>
    </v-card>
  </v-form>
</template>
 
<script>
import EmailField from "~/components/TextFieldComponents/EmailField.vue";
import PasswordField from "~/components/TextFieldComponents/PasswordField.vue";
export default {
  components: { EmailField, PasswordField },
  data() {
    return {
      email: "",
      password: "",
    };
  },
  methods: {
    submit() {
      console.log(this.email + "," + this.password);
    },
  },
};
</script>