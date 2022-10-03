<template>
  <v-text-field
    v-model="setEmail"
    :value="email"
    :rules="rules"
    label="メールアドレス"
    prepend-icon="mdi-mail"
    :placeholder="form.placeholder"
    outlined
  >
  </v-text-field>
</template>
<script>
export default {
  props: {
    email: {
      type: String,
      default: '',
      required: true,
    },
    noValidation: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      rules: [(v) => !!v || '', (v) => /.+@.+\..+/.test(v) || ''],
    }
  },
  computed: {
    setEmail: {
      get() {
        return this.email
      },
      set(newVal) {
        return this.$emit('update:email', newVal)
      },
    },
    form() {
      const placeholder = this.noValidation ? undefined : 'your@email.com'
      return { placeholder }
    },
  },
}
</script>
