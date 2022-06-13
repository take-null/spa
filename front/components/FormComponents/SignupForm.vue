<template>
  <v-form>
    <v-card width="400px">
      <!-- タイトル -->
      <v-card-title class="headline">新規登録</v-card-title>
 
      <!-- 入力欄 -->
      <v-card-text>
        <NameField :name.sync="name" />
        <EmailField :email.sync="email" />
        <PasswordField :password.sync="password" />
        <PasswordConfirmationField :passwordConfirmation.sync="passwordConfirmation" />
      </v-card-text>
 
      <!-- アクションボタン -->
      <v-card-actions>
        <v-btn @click="submit">新規登録</v-btn>
      </v-card-actions>
    </v-card>
  </v-form>
</template>
 
<script>
import NameField from "~/components/TextFieldComponents/NameField.vue";
import EmailField from "~/components/TextFieldComponents/EmailField.vue";
import PasswordField from "~/components/TextFieldComponents/PasswordField.vue";
import PasswordConfirmationField from "~/components/TextFieldComponents/PasswordConfirmationField.vue";
export default {
  components: { NameField, EmailField, PasswordField, PasswordConfirmationField },
  data() {
    return {
      email: "",
      password: "",
    };
  },
  methods: {
    submit() {
      console.log(this.name + "," + this.email + "," + this.password +"," + this.passwordConfirmation);
    },
  },
};
</script>