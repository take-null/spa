<template>
  <v-form>
    <NameField :name.sync="name" />
    <EmailField :email.sync="email" />
    <PasswordField :password.sync="password" />
    <PasswordConfirmationField :passwordConfirmation.sync="passwordConfirmation" />
    {{this.name}},{{this.email}},{{this.password}},{{this.passwordConfirmation}}
    <v-card-actions>
      <v-btn>新規登録</v-btn>
    </v-card-actions>
    <v-card-actions>
      <v-btn to="/login" nuxt>ログイン</v-btn>
    </v-card-actions>
  </v-form>
</template>

<script>
import NameField from "~/components/TextFieldComponents/NameField.vue";
import EmailField from "~/components/TextFieldComponents/EmailField.vue";
import PasswordField from "~/components/TextFieldComponents/PasswordField.vue";
import PasswordConfirmationField from "~/components/TextFieldComponents/PasswordConfirmationField.vue";

export default {
  data() {
    return {
      name: "",
      email: "",
      password: "",
      passwordConfirmation: ""
    };      
  },
  components: { NameField, EmailField, PasswordField, PasswordConfirmationField },
};
</script>