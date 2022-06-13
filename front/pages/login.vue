<template>
  <v-form>
    <EmailField :email.sync="email" />
    <PasswordField :password.sync="password" />
    {{this.email}},{{this.password}}
    <v-card-actions>
      <v-btn>ログイン</v-btn>
    </v-card-actions>
    <v-card-actions>
      <v-btn to="/signup" nuxt>新規登録</v-btn>
    </v-card-actions>
  </v-form>
</template>

<script>
import EmailField from "~/components/TextFieldComponents/EmailField.vue";
import PasswordField from "~/components/TextFieldComponents/PasswordField.vue";

export default {
  data() {
    return {
      email: "",
      password: ""
    };      
  },
  components: { EmailField, PasswordField },
};
</script>