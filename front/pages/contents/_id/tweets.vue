<template>
  <v-container fluid>
    <v-card
      flat
      tile
      color="transparent"
    >
        <v-container fluid>
          <v-row dense>
            <v-col
              v-for="tweet in tweets" :key="tweet.id"
              cols="12" sm="6" md="4" lg="3" xl="2"
              class="d-flex align-end"
            >
              <myTweetsCard
                :name.sync="tweet.name"
                :content.sync="tweet.content"
                :created_at.sync="tweet.created_at"
              />
            </v-col>
          </v-row>
        </v-container>

      <v-card>
        <tweetPost
          :tweet_content.sync="params.tweet_content" 
        />
      </v-card>
    </v-card>
  </v-container>
</template>
<script>
//削除予定
import tweetPost from '~/components/tweets/tweetPost.vue'
import myTweetsCard from '~/components/tweets/myTweetsCard.vue'
export default {
  components: { myTweetsCard, tweetPost },
    //layout ({ $nxauth }) {
    //return $nxauth.loggedIn ? 'loggedIn' : 'welcome'
  //},
  async asyncData ({ $axios }) {
    let tweets = []
    await $axios.$get(`/api/v1/tweets`).then(res => (
    tweets = res.data,
    console.log(tweets)))
    const tweetKeys = Object.keys(tweets[0] || {}) // 追加
    console.log(tweetKeys)
    return { tweets, tweetKeys }
  },
  // data () 追加
  data () {
    return {
      dialog: false,
      params: { tweet_content: "" }
    }
  },
}
</script>