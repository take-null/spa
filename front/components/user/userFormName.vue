<template>
  <v-text-field
    v-model="setName"
    :value="name"
    :rules="rules"
    :counter="max"
    label="名前"
    prepend-icon="mdi-account-circle"
    placeholder="あなたの名前"
    outlined
  >
  </v-text-field>
</template>

<script>
export default {
  props: {
    name: {
      type: String,
      default: '',
      required: true,
    },
  },
  data() {
    const max = 30
    return {
      max,
      rules: [
        (v) => !!v || '',
        (v) => (!!v && max >= v.length) || `${max}文字以内で入力してください`,
      ],
    }
  },
  computed: {
    setName: {
      get() {
        return this.name
      },
      set(newVal) {
        return this.$emit('update:name', newVal)
      },
    },
  },
}
</script>
