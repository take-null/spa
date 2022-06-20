<template>
  <before-login-form-card>
    <template
      #form-card-content
    >
      <v-form
        v-model="isValid"
      >
        <user-form-name />
        <user-form-email />
        <user-form-password />
        <user-frorm-password-confirmation />
        <v-btn
          :disabled="!isValid"
          block
          color="blue"
          class="white--text"
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
      isValid: false
    }
  }
};
</script>
