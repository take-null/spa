<template>
  <v-textarea
    v-model="setSurveyContent"
    rows="5"
    :value="content"
    :rules="rules"
    :counter="max"  
    label="ご意見・ご要望" 
    placeholder="〇〇してほしい！"
    clearable
    outlined
  >
  </v-textarea>
</template>
    
<script>
export default {
  props: { 
    content: {
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
    setSurveyContent: {
      get () { return this.content },
      set (newVal) { return this.$emit('update:content', newVal) }
    }
  }
};
</script>