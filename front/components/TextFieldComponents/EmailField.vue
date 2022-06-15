<template>
  <v-text-field
    v-model="setEmail" 
    :value="email"
    label="メールアドレス"
    prepend-icon="mdi-mail"
    placeholder="your@email.com"
    outlined
  >
  </v-text-field>
</template>
<script>
export default {
  props: { 
    email: {
      type: String,
      default: "",
      required: true
    }       
  },
  computed: {
    setEmail: {
      get () { return this.email },
      set (newVal) { return this.$emit('update:email', newVal) }
    }
  }
}
</script>
