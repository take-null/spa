<template>
  <v-text-field 
    :value="passwordConfirmation" 
    label="パスワード(確認)"
        prepend-icon="mdi-lock"
    :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
    :type="show ? 'text' : 'password'"
    hint="最小６文字"
    counter
    @click:append="show = !show"
    @input="$emit('update:passwordConfirmation', $event)"
  >
  </v-text-field>
</template>
<script>
export default {
  props: { 
    passwordConfirmation: {
      type: String,
      default: "",
      required: true,
    },   
  },
  data() {
    return {
      show: false,
    };
  },
};
</script>