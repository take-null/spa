<template>
  <v-text-field
    v-model="setPassword"
    :rules="form.rules"
    label="パスワードを入力"
    prepend-icon="mdi-lock"
    :append-icon="toggle.icon"
    :type="toggle.type"
    :hint="form.hint"
    :counter="!noValidation"
    @click:append="show = !show"
    :placeholder="form.placeholder"
    :hide-details="noValidation"
    autocomplete="on"
    outlined
  >
  </v-text-field>
</template>
<script>
export default {
  props: {
    password: {
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
      show: false,
    }
  },
  computed: {
    setPassword: {
      get() {
        return this.password
      },
      set(newVal) {
        return this.$emit('update:password', newVal)
      },
    },
    form() {
      const min = '8文字以上'
      const msg = `${min}。半角英数字、ハイフン、アンダーバーが使えます`
      const required = (v) => !!v || ''
      const format = (v) => /^[\w-]{8,72}$/.test(v) || msg

      const rules = this.noValidation ? [required] : [format]
      const hint = this.noValidation ? undefined : msg
      const placeholder = this.noValidation ? undefined : min
      return { rules, hint, placeholder }
    },
    toggle() {
      const icon = this.show ? 'mdi-eye' : 'mdi-eye-off'
      const type = this.show ? 'text' : 'password'
      return { icon, type }
    },
  },
}
</script>
