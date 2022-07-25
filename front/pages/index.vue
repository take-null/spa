<template>
  <v-app id="inspire">
    <v-container
      class="py-8 px-6"
      fill-height
    >
      <v-row
        no-gutters
      >
        <v-col
          cols="2"
        >
          <v-card
            color="blue-grey lighten-5"
            elevation="0"
            max-width="370"
            min-height="70vh"
          >
            <v-card-title
              class="pb-0"
            >
              <p class="text-h6 text--primary">
                Tags
              </p>
            </v-card-title>
            <v-container
              fluid
            >
              <v-row
                dense
              >
                <v-col
                  v-for="tag in tags"
                  :key="tag.id"
                >
                  <v-card-actions>
                    <v-btn
                      text
                      @click.stop="searchTag(tag.name)"
                    >
                      <v-card-subtitle
                        class="text-body-2 text--primary"
                      >
                        <v-icon
                          dark
                        >
                          mdi-label
                        </v-icon>
                        {{tag.name}}({{tag.taggings_count}})
                      </v-card-subtitle>
                    </v-btn>
                  </v-card-actions>
                </v-col>
              </v-row>
            </v-container>
          </v-card>
        </v-col>
        <v-col
          cols="6"
        >
          <template
            v-if="searchFlag === false"
          >
            <v-container
              fluid
            >
              <v-row
                dense
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
                    :tags.sync="book.tags"
                    @toShowParent="toShow"
                  />
                </v-col>
              </v-row>
            </v-container>
          </template>
          <template
            v-else
          >
            <v-container
              fluid
            >
              <v-row
                dense
              >
                <v-card
                  class="mx-auto"
                  max-width="425"
                  dark
                >
                  <v-card-actions>
                    <v-btn
                      @click="searchFlag=false"
                      block
                      dark
                      class="white--text"
                      elevation="0"
                    >
                      <v-icon>
                        mdi-refresh
                      </v-icon>return
                    </v-btn>
                  </v-card-actions>
                </v-card>
                <v-col
                  v-for="book in formattedShelves"
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
                    :tags.sync="book.tags"
                    @toShowParent="toShow"
                  />
                </v-col>
              </v-row>
            </v-container>
          </template>
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
    let tags = await $axios.$get(`/api/v1/books_shelves/tag`)
    const formattedBooks = books.map(book => {let time = formatDistanceToNow(new Date(book.created_at), { locale: ja })
        return { ...book, created_at: time }
    })
    console.log(books)
    const bookKeys = Object.keys(books || {}) // 追加
    const rankKeys = Object.keys(ranking || {}) // 追加
    const tagKeys = Object.keys(tags || {}) // 追加
    return { formattedBooks, bookKeys, ranking, rankKeys, tags, tagKeys }
    
  },
  data: () => ({
    reveal: false,
    searchFlag: false,
    formattedShelves: []
  }),
  methods: {
    toShow(id) {
        if (id !== this.$nxauth.user.id) {
        this.$router.push(`/user/${id}`)
      }
    },
    async searchTag (tag) {
    let shelves = await this.$axios.$get(`/api/v1/books_shelves/search?tag=${tag}`)
    const formattedShelves = shelves.map(shelf => {let time = formatDistanceToNow(new Date(shelf.created_at), { locale: ja })
        return { ...shelf, created_at: time }
    })
    const shelfKeys = Object.keys(shelves || {}) // 追加
    console.log(formattedShelves)
    this.formattedShelves = formattedShelves
    this.searchFlag = true
    return { formattedShelves, shelfKeys }
    },
  }
};
</script>

