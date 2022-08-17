<template>
  <v-text-field
    v-model="setProfile"
    :value="profile"
    :rules="rules"
    :counter="max"  
    label="プロフィールを入力" 
    placeholder="こんにちは"
    outlined
  >
  </v-text-field>
</template>

<script>
export default {
  props: { 
    profile: {
      type: String,
      default: "",
      required: false
    }    
  },
  data () {
    const max = 140
    return {
      max,
      rules: [
        v => !!v || '',
        v => (!!v && max >= v.length) || `${max}文字以内で入力してください`
      ]
    }
  },
  computed: {
    setProfile: {
      get () { return this.profile },
      set (newVal) { return this.$emit('update:profile', newVal) }
    }
  }
};
</script>