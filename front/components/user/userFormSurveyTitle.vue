<template>
  <v-text-field
    v-model="setSurveyTitle"
    :value="title"
    :rules="rules"
    :counter="max"  
    label="タイトルを入力" 
    placeholder="〇〇機能について"
    clearable
    outlined
  >
  </v-text-field>
</template>
  
<script>
export default {
  props: { 
    title: {
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
    setSurveyTitle: {
      get () { return this.title },
      set (newVal) { return this.$emit('update:title', newVal) }
    }
  }
};
</script>