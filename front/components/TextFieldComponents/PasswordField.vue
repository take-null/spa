<template>
  <v-text-field
    v-model="setPassword"
    :value="password" 
    label="パスワード"
    prepend-icon="mdi-lock"
    :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
    :type="show ? 'text' : 'password'"
    hint="最小６文字"
    counter
    @click:append="show = !show"
    placeholder="パスワードを入力"
    outlined
  >
  </v-text-field>
</template>
<script>
export default {
  props: { 
    password: {
      type: String,
      default: "",
      required: true
    }     
  },
  computed: {
    setPassword: {
      get () { return this.password },
      set (newVal) { return this.$emit('update:password', newVal) }
    }
  }
}
</script>