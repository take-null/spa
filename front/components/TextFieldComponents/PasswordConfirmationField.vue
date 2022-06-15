<template>
  <v-text-field
    v-model="setPasswordConfirmation"
    :value="passwordConfirmation" 
    label="パスワード(確認)"
    prepend-icon="mdi-lock"
    :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
    :type="show ? 'text' : 'password'"
    hint="最小６文字"
    counter
    @click:append="show = !show"
    placeholder="パスワードを入力(確認用)"
    outlined
  >
  </v-text-field>
</template>
<script>
export default {
  props: { 
    passwordConfirmation: {
      type: String,
      default: "",
      required: true
    }   
  },
  computed: {
    setPasswordConfirmation: {
      get () { return this.passwordConfirmation },
      set (newVal) { return this.$emit('update:passwordConfirmation', newVal) }
    }
  }
}
</script>