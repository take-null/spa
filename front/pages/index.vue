<template>
  <v-app id="inspire">
    <v-container
      class="py-8 px-6"
      fluid
    >
      <v-row
        dense
      >
        <v-col
          cols="8"
        >
          <v-card
           color="transparent"
           elevation="0"
          >
            <v-col
              v-for="book in formattedBooks"
              :key="book.id"
              cols="12"
            >
              <bookReview
                :book_image.sync="book.book_image"
                :comment.sync="book.comment"
                :created_at.sync="book.created_at"
                :google_books_api_id.sync="book.google_books_api_id"
                :id.sync="book.id"
                :rating.sync="book.rating"
                :title.sync="book.title"
                :user_id.sync="book.user_id"
                :user_image.sync="book.user_image"
                :user_name.sync="book.user_name"
                @toShowParent="toShow"
              />
            </v-col>
          </v-card>
        </v-col>
        <v-col
          cols="4"
        >
          <v-card
            color="blue-grey lighten-5"
            elevation="0"
            max-width="370"
          >
            <v-card-title
              class="pb-0"
            >
              <p class="text-h6 text--primary">
                Ranking(top10)
              </p>
            </v-card-title>
            <v-col
              v-for="rank in ranking"
              :key="rank.google_books_api_id"
              cols="12"
            >
              <bookRank
                :image.sync="rank.book_image"
                :title.sync="rank.title"
                :rank.sync="rank.rank"
                :google_books_api_id.sync="rank.google_books_api_id"
              />
            </v-col>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </v-app>
</template>

<script>
import { formatDistanceToNow } from 'date-fns'
import { ja } from 'date-fns/locale'
import bookReview from '~/components/books/bookReview.vue'
import bookRank from '~/components/books/bookRank.vue'
export default {
  layout ({ $nxauth }) {
    return $nxauth.loggedIn ? 'loggedIn' : 'welcome'
  },
  components: { bookReview, bookRank },
  async asyncData ({ $axios }) {
    let books = await $axios.$get(`/api/v1/books_shelves/all`)
    let ranking = await $axios.$get(`/api/v1/books_shelves/rank`)
    const formattedBooks = books.map(book => {let time = formatDistanceToNow(new Date(book.created_at), { locale: ja })
        return { ...book, created_at: time }
    })
    const bookKeys = Object.keys(books || {}) // 追加
    const rankKeys = Object.keys(ranking || {}) // 追加
    return { formattedBooks, bookKeys, ranking, rankKeys }
    
  },
  data: () => ({
    reveal: false,
  }),
  methods: {
    toShow(id) {
        if (id !== this.$nxauth.user.id) {
        this.$router.push(`/user/${id}`)
      }
    }
  }
};
</script>

