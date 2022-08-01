<template>
  <v-app id="inspire">
    <v-container
      class="py-8 px-6"
      fill-height
      fluid
      id="top"
    >
      <v-row
        no-gutters
      >
        <v-sheet 
          elevation="0"
          color="blue-grey lighten-5" 
        >
          <v-tabs
            background-color="blue-grey lighten-5"
            next-icon="mdi-chevron-right"
            prev-icon="mdi-chevron-left"
            show-arrows
          >
            <v-tab
              @click.stop="searchTag(tag.name)"
              v-for="tag in tags"
              :key="tag.id"
              :href="'#tab-' + tag.id"
            >
              <p
                class="text-button text--cyan"
              >
                #{{tag.name}}({{tag.taggings_count}})
              </p>
            </v-tab>
          </v-tabs>
        </v-sheet>
      </v-row>
      <v-row
        no-gutters
      >
        <v-col
          cols="9"
        >
          <template
            v-if="searchFlag === false"
          >
            <v-container
              fluid
            >
              <v-row
                no-gutters
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
                    :goodArray.sync="book.good"
                    @toShowParent="toShow"
                    @searchTagParent="searchTag"
                  />
                </v-col>
              </v-row>
            </v-container>
            <infinite-loading @infinite="infiniteHandler"></infinite-loading>
          </template>
          <template
            v-else
          >
            <v-container
              fluid
            >
              <v-row
                no-gutters
              >
                <v-card
                  class="mx-auto"
                  max-width="600"
                  dark
                  elevation="0"
                  @click="searchFlag=false"
                >
                  <p
                    class="text-subtitle-1 white--text"
                  >
                    <v-icon>
                      mdi-refresh
                    </v-icon>
                      return
                  </p>
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
                    @searchTagParent="searchTag"
                  />
                </v-col>
              </v-row>
            </v-container>
          </template>
        </v-col>
        <v-col
          cols="3"
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
            <v-row
              no-gutters
            >
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
                  @searchRankParent="searchRank"
                />
              </v-col>
            </v-row>
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
  data: () => ({
    reveal: false,
    searchFlag: false,
    formattedShelves: [],
    page: 2
  }),
  async asyncData ({ $axios }) {
    let books = await $axios.$get(`/api/v1/books_shelves/all`)
    let ranking = await $axios.$get(`/api/v1/books_shelves/rank`)
    let tags = await $axios.$get(`/api/v1/books_shelves/tag`)
    const formattedBooks = books.books.map(book => {let time = formatDistanceToNow(new Date(book.created_at), { locale: ja })
        return { ...book, created_at: time }
    })
    console.log(tags)
    const bookKeys = Object.keys(books.books || {}) // 追加
    const rankKeys = Object.keys(ranking || {}) // 追加
    const tagKeys = Object.keys(tags || {}) // 追加
    
    return { formattedBooks, bookKeys, ranking, rankKeys, tags, tagKeys }
  },
  methods: {
    toShow(id) {
        if (id !== this.$nxauth.user.id) {
        this.$router.push(`/user/${id}`)
      }
    },
    goTo () {
      this.$vuetify.goTo(`#top`)
    },
    async searchTag (tag) {
      let shelves = await this.$axios.$get(`/api/v1/books_shelves/search?tag=${tag}`)
      const formattedShelves = shelves.map(shelf => {let time = formatDistanceToNow(new Date(shelf.created_at), { locale: ja })
        return { ...shelf, created_at: time }
      })
      this.goTo()
      const shelfKeys = Object.keys(shelves || {}) // 追加
      console.log(formattedShelves)
      this.formattedShelves = formattedShelves
      this.searchFlag = true
      return { formattedShelves, shelfKeys }
    },
    async searchRank (google_books_api_id) {
      let shelves = await this.$axios.$get(`/api/v1/books_shelves/view?google_books_api_id=${google_books_api_id}`)
      const formattedShelves = shelves.map(shelf => {let time = formatDistanceToNow(new Date(shelf.created_at), { locale: ja })
        return { ...shelf, created_at: time }
      })
      this.goTo()
      const shelfKeys = Object.keys(shelves || {}) // 追加
      console.log(formattedShelves)
      this.formattedShelves = formattedShelves
      this.searchFlag = true
      return { formattedShelves, shelfKeys }
    },
    infiniteHandler($state) {
      this.$axios.$get(`/api/v1/books_shelves/all`, {
          params: {
              page: this.page , 
          },
      }).then((res) => {
        const books = res.books.map(book => {let time = formatDistanceToNow(new Date(book.created_at), { locale: ja })
          return { ...book, created_at: time }
        })
        setTimeout(() => {
          if (this.page <= res.kaminari.pagenation.pages) {
            this.page += 1
            let num = 0;
            while(num <= books.length - 1) {
              this.formattedBooks.push(books[num]);
              num++;
            }
            $state.loaded()
          } else {
            this.goTo()
            this.page = 1,
            this.$axios.$get(`/api/v1/books_shelves/all?page=${this.page}`).then((res) => {
            this.formattedBooks = res.books.map(book => {let time = formatDistanceToNow(new Date(book.created_at), { locale: ja })
              return { ...book, created_at: time }
            })})
            this.page = 2
            this.infiniteHandler($state)
          }
        }, 800)
      }).catch((err) => {
        $state.complete()
      })
    }
  }
};
</script>