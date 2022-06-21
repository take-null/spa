<template>
  <before-login-form-card>
    <template
      #form-card-content
    >
      <v-form
        ref="form"
        v-model="isValid"
      >
        <user-form-name 
          :name.sync="params.user.name"
        />
        <user-form-email 
          :email.sync="params.user.email"
        />
        <user-form-password 
          :password.sync="params.user.password"
        />
        <user-frorm-password-confirmation 
          :passwordConfirmation.sync="params.user.passwordConfirmation"
        />
        <v-btn
          :disabled="!isValid || loading"
          :loading="loading"
          block
          color="blue"
          class="white--text"
          @click="signup"
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
  data () {
    return {
      isValid: false,
      loading: false,
      params: { user: { name: '', email: '', password: '', passwordConfirmation: "" } }
    }
  },
  methods: {
    signup () {
        this.loading = true
        setTimeout(() => {
            this.formReset()
            this.loading = false
        }, 1500)
    },
    formReset () {
        this.$refs.form.reset()
        this.params = { user: { name: '', email: '', password: '', passwordConfirmation: "" } }
    }
  }
};
</script>
