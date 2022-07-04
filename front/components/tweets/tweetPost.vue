<template>
  <v-card
    color="grey lighten-2"
  >
    <template>
      <v-card-title class="text-h6 font-weight-bold">Form</v-card-title>
        <v-form
          ref="form"
          v-model="isValid"
        >
          <userFormTweet 
            :content.sync="params.tweet_content"
          />
          <div>{{error}}</div>
          <v-btn
            :disabled="!isValid || loading"
            :loading="loading"
            block
            color="light-blue darken-1"
            class="white--text"
            @click.prevent="post"
          >
          投稿する
          </v-btn>
      </v-form>
    </template>
  </v-card>
</template>

<script>
import userFormTweet from '~/components/user/userFormTweet.vue'
export default {
  components: { userFormTweet },
  props: {
    tweet_content: {
      type: String
    }
  },
  data () {
    return {
      isValid: false,
      loading: false,
      params: { tweet_content: "" },
      error: null
    }
  },
  methods: {
    async post () {
      try {
        this.loading = true
        const formData = new FormData()
        formData.append('tweet_content', this.params.tweet_content)
        await this.$axios.post('api/v1/tweets', formData)
          .then(
            (res) => { 
            this.loading = false
            this.$router.go({path: this.$router.currentRoute.path, force: true})
            return res
          }
        )
        //responseを表示 
        //console.log({res})
        } catch (error) {
          console.log({error})
          this.loading = false
          this.error = '投稿に失敗しました。'
          this.formReset()
        }
      },
      formReset () {
        this.$refs.form.reset()
        this.params = { tweet_content: '' }
      }
   },
};
</script>