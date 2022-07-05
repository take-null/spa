<template>
  <v-text-field
    v-model="setTweet"
    :value="tweet_content"
    :rules="rules"
    :counter="max"  
    label="呟きを投稿" 
    outlined
  >
  </v-text-field>
</template>

<script>
export default {
  props: { 
    tweet_content: {
      type: String,
      default: "",
      required: false
    }    
  },
  data () {
    const max = 250
    return {
      max,
      rules: [
        v => !!v || '',
        v => (!!v && max >= v.length) || `${max}文字以内で入力してください`
      ]
    }
  },
  computed: {
    setTweet: {
      get () { return this.tweet_content },
      set (newVal) { return this.$emit('update:content', newVal) }
    }
  }
};
</script>