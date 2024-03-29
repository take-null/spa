<template>
  <v-app id="inspire">
    <v-container :style="{ maxWidth: '1300px' }" class="py-8 px-6">
      <v-row dense>
        <div class="text-sm-subtitle-1 mb-4">Tags</div>
        <v-sheet elevation="0" color="blue-grey lighten-5">
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
              <p class="text-button text--cyan">
                #{{ tag.name }}({{ tag.taggings_count }})
              </p>
            </v-tab>
          </v-tabs>
        </v-sheet>
      </v-row>
      <v-row no-gutters justify="center">
        <v-col cols="12" sm="4" md="4" lg="2" xl="2">
          <div class="text-sm-subtitle-1 mb-4">Ranking</div>
          <v-carousel
            cycle
            height="300"
            hide-delimiters
            hide-delimiter-background
            show-arrows-on-hover
          >
            <v-carousel-item v-for="(rank, i) in ranking" :key="i">
              <bookRank
                :image.sync="rank.book_image"
                :rank.sync="rank.rank"
                :google_books_api_id.sync="rank.google_books_api_id"
                @searchRankParent="searchRank"
              />
            </v-carousel-item>
          </v-carousel>
        </v-col>
        <v-col cols="12" sm="8" md="8" lg="10" xl="10">
          <template v-if="searchFlag === false">
            <v-container fluid>
              <v-row no-gutters>
                <v-col v-for="book in formattedBooks" :key="book.id" cols="12">
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
          <template v-else>
            <v-container fluid>
              <v-row no-gutters>
                <v-card
                  class="mx-auto"
                  max-width="768"
                  color="grey lighten-2"
                  elevation="0"
                  @click="searchFlag = false"
                >
                  <p class="text-subtitle-1">
                    <v-icon> mdi-refresh </v-icon>
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
                    :goodArray.sync="book.good"
                    @toShowParent="toShow"
                    @searchTagParent="searchTag"
                  />
                </v-col>
                <v-card
                  class="mx-auto"
                  max-width="768"
                  color="grey lighten-2"
                  elevation="0"
                  @click="goTo()"
                >
                  <p class="text-subtitle-1">
                    <v-icon> mdi-arrow-up-circle-outline </v-icon>
                    goTo
                  </p>
                </v-card>
              </v-row>
            </v-container>
          </template>
        </v-col>
      </v-row>
      <transition>
        <v-btn
          fixed
          fab
          bottom
          right
          color="primary"
          style="bottom: 50px"
          @click.prevent="moveSearchPage()"
        >
          <v-icon color="white"> mdi-book-open-page-variant-outline </v-icon>
          +
        </v-btn>
      </transition>
    </v-container>
  </v-app>
</template>

<script>
import { formatDistanceToNow } from 'date-fns'
import { ja } from 'date-fns/locale'
import bookReview from '~/components/books/bookReview.vue'
import bookRank from '~/components/books/bookRank.vue'
export default {
  layout({ $nxauth }) {
    return $nxauth.loggedIn ? 'loggedIn' : 'welcome'
  },
  components: {
    bookReview,
    bookRank,
  },
  data: () => ({
    reveal: false,
    searchFlag: false,
    formattedShelves: [],
    page: 2,
  }),
  async asyncData({ $axios }) {
    let books = await $axios.$get('/api/v1/books_shelves/all')
    let ranking = await $axios.$get('/api/v1/books_shelves/rank')
    let tags = await $axios.$get('/api/v1/books_shelves/tag')
    const formattedBooks = books.books.map((book) => {
      let time = formatDistanceToNow(new Date(book.created_at), { locale: ja })
      return { ...book, created_at: time }
    })
    return { formattedBooks, ranking, tags }
  },
  methods: {
    toShow(id) {
      if (id !== this.$store.state.current.user.id) {
        this.$router.push(`/user/${id}`)
      }
    },
    moveSearchPage() {
      this.$router.replace('/contents/1/books')
    },
    goTo() {
      this.$vuetify.goTo('#inspire')
    },
    async searchTag(tag) {
      let shelves = await this.$axios.$get(
        `/api/v1/books_shelves/search?tag=${tag}`
      )
      const formattedShelves = shelves.map((shelf) => {
        let time = formatDistanceToNow(new Date(shelf.created_at), {
          locale: ja,
        })
        return { ...shelf, created_at: time }
      })
      this.goTo()
      this.formattedShelves = formattedShelves
      this.searchFlag = true
      return { formattedShelves }
    },
    async searchRank(google_books_api_id) {
      let shelves = await this.$axios.$get(
        `/api/v1/books_shelves/view?google_books_api_id=${google_books_api_id}`
      )
      const formattedShelves = shelves.map((shelf) => {
        let time = formatDistanceToNow(new Date(shelf.created_at), {
          locale: ja,
        })
        return { ...shelf, created_at: time }
      })
      this.formattedShelves = formattedShelves
      this.searchFlag = true
      return { formattedShelves }
    },
    infiniteHandler($state) {
      if (this.formattedBooks.length) {
        this.$axios
          .$get('/api/v1/books_shelves/all', {
            params: {
              page: this.page,
            },
          })
          .then((res) => {
            const books = res.books.map((book) => {
              let time = formatDistanceToNow(new Date(book.created_at), {
                locale: ja,
              })
              return { ...book, created_at: time }
            })
            setTimeout(() => {
              if (this.page <= res.kaminari.pagenation.pages) {
                this.page += 1
                let num = 0
                while (num <= books.length - 1) {
                  this.formattedBooks.push(books[num])
                  num++
                }
                $state.loaded()
              } else {
                this.goTo()
                ;(this.page = 1),
                  this.$axios
                    .$get(`/api/v1/books_shelves/all?page=${this.page}`)
                    .then((res) => {
                      this.formattedBooks = res.books.map((book) => {
                        let time = formatDistanceToNow(
                          new Date(book.created_at),
                          { locale: ja }
                        )
                        return { ...book, created_at: time }
                      })
                    })
                this.page = 2
                this.infiniteHandler($state)
              }
            }, 800)
          })
          .catch((err) => {
            console.log(err)
            $state.complete()
          })
      }
    },
  },
}
</script>
