<template>
  <v-container fluid>
    <v-card
      flat
      tile
      color="transparent"
    >
      <div>
        <v-container fluid>
          <v-row>
            <v-col
              v-for="tweet in tweets" :key="tweet.id">
              <myTweetsCard
                :name.sync="tweet.name"
                :content.sync="tweet.content"
                :created_at.sync="tweet.created_at"
              />
            </v-col>
          </v-row>
        </v-container>
      </div>
    </v-card>
  </v-container>
</template>
<script>
//削除予定
import myTweetsCard from '~/components/tweets/myTweetsCard.vue'
export default {
  components: { myTweetsCard },
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
    }
  },
}
</script>