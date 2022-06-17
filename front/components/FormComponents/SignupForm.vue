<template>
  <v-form v-model="isValid">
    <v-card width="400px">
      <!-- タイトル -->
      <v-card-title class="headline">新規登録</v-card-title>
 
      <!-- 入力欄 -->
      <v-card-text>
        <NameField 
          :name.sync="params.user.name"
        />
        <EmailField
          :email.sync="params.user.email" 
        />
        <PasswordField 
          :password.sync="params.user.password" 
        />
        <PasswordConfirmationField
          :passwordConfirmation.sync="params.user.passwordConfirmation"
        />
      </v-card-text>
 
      <!-- アクションボタン -->
      <v-card-actions>
        <v-btn 
          :disabled="!isValid"
          @click="registerUser"
        >新規登録
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-form>

</template>
 
<script>
import NameField from "~/components/TextFieldComponents/NameField.vue";
import EmailField from "~/components/TextFieldComponents/EmailField.vue";
import PasswordField from "~/components/TextFieldComponents/PasswordField.vue";
import PasswordConfirmationField from '../TextFieldComponents/PasswordConfirmationField.vue';
export default {
  components: { NameField, EmailField, PasswordField, PasswordConfirmationField },
  //auth: false,
  data() {
    return {
      isValid: false,
      params: { user: { name: "", email: "", password: "", passwordConfirmation: "" } }
    }
  },
  methods: {
    async registerUser () {
      this.$axios.post('/api/v1/auth', {params}).then((response) => {
        window.location.href = '/users/confirmation'
      })
    },
  },
}
</script>