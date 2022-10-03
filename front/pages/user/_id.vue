<template>
  <v-app>
    <v-container v-if="presense">
      <v-card color="blue-grey lighten-5" rounded="lg" max-width="600">
        <v-card-title class="text-h6 center">
          ログインユーザーはこのページにアクセスできません
        </v-card-title>
        <b-container
          class="d-flex justify-content-center"
          color="blue-grey lighten-5"
        >
          <v-btn text rounded outlined @click="toTop()"> close </v-btn>
        </b-container>
      </v-card>
    </v-container>
    <v-container v-else>
      <v-snackbar
        v-model="followSnackbar"
        max-width="600"
        color="primary"
        absolute
        outlined
        text
        top
      >
        <p class="font-italic">
          <v-icon> mdi-checkbox-marked-circle-plus-outline </v-icon>
          {{ user.name }}をフォローしました
        </p>
      </v-snackbar>
      <v-snackbar
        v-model="unfollowSnackbar"
        max-width="600"
        color="primary"
        absolute
        outlined
        text
        top
      >
        <p class="font-italic">
          <v-icon> mdi-checkbox-marked-circle </v-icon>
          {{ user.name }}のフォローを解除しました
        </p>
      </v-snackbar>
      <v-row>
        <template v-if="width > 600">
          <v-col cols="3">
            <v-card color="blue-grey lighten-5" rounded="lg" max-width="600">
              <b-container
                class="d-flex justify-content-end"
                color="blue-grey lighten-5"
              >
                <v-btn text rounded outlined @click="toTop()"> close </v-btn>
              </b-container>
              <otherProfile
                :id.sync="user.id"
                :name.sync="user.name"
                :image.sync="user.image.url"
                :profile.sync="user.profile"
                :age.sync="user.age"
                :locate.sync="user.locate"
                :following.sync="user.following"
                :followers.sync="user.followers"
                :good.sync="user.goods"
                :review.sync="review"
              />
              <b-container class="d-flex justify-content-end">
                <v-btn text rounded outlined @click="createRoom">
                  <v-icon> mdi-email-outline </v-icon>
                  Chat
                </v-btn>
              </b-container>
              <b-container class="d-flex justify-content-end">
                <v-btn
                  v-if="flag"
                  text
                  rounded
                  outlined
                  small
                  @click="unfollowUser"
                >
                  unFollow
                </v-btn>
                <v-btn v-else rounded color="primary" @click="followUser">
                  Follow
                </v-btn>
              </b-container>
            </v-card>
          </v-col>
          <v-col cols="9">
            <v-card
              v-if="width > 600 && width < 768"
              color="blue-grey lighten-5"
              max-width="600"
            >
              <v-card-title> {{ user.name }}'sBooks </v-card-title>
              <v-container fluid>
                <v-row>
                  <v-col
                    v-for="book in books"
                    :key="book.id"
                    cols="4"
                    class="d-flex align-end"
                  >
                    <bookDetail
                      :user_id.sync="book.user_id"
                      :book_image.sync="book.book_image"
                      :comment.sync="book.comment"
                      :created_at.sync="book.created_at"
                      :google_books_api_id.sync="book.google_books_api_id"
                      :id.sync="book.id"
                      :rating.sync="book.rating"
                      :title.sync="book.title"
                      :tags.sync="book.tags"
                      :goodArray.sync="book.good"
                      :authors.sync="book.authors"
                      :publisher.sync="book.publisher"
                      :published_at.sync="book.published_at"
                    />
                  </v-col>
                </v-row>
                <v-row justify="center">
                  <v-col cols="8">
                    <v-container class="max-width">
                      <v-pagination
                        v-model="page"
                        :length="total"
                        @input="movePage"
                      >
                      </v-pagination>
                    </v-container>
                  </v-col>
                </v-row>
              </v-container>
            </v-card>
            <v-card v-else color="blue-grey lighten-5" max-width="960">
              <v-card-title> {{ user.name }}'sBooks </v-card-title>
              <v-container fluid>
                <v-row>
                  <v-col
                    v-for="book in books"
                    :key="book.id"
                    cols="12"
                    sm="4"
                    md="3"
                    lg="3"
                    xl="2"
                    class="d-flex align-end"
                  >
                    <bookDetail
                      :user_id.sync="book.user_id"
                      :book_image.sync="book.book_image"
                      :comment.sync="book.comment"
                      :created_at.sync="book.created_at"
                      :google_books_api_id.sync="book.google_books_api_id"
                      :id.sync="book.id"
                      :rating.sync="book.rating"
                      :title.sync="book.title"
                      :tags.sync="book.tags"
                      :goodArray.sync="book.good"
                      :authors.sync="book.authors"
                      :publisher.sync="book.publisher"
                      :published_at.sync="book.published_at"
                    />
                  </v-col>
                </v-row>
                <v-row justify="center">
                  <v-col cols="8">
                    <v-container class="max-width">
                      <v-pagination
                        v-model="page"
                        :length="total"
                        @input="movePage"
                      >
                      </v-pagination>
                    </v-container>
                  </v-col>
                </v-row>
              </v-container>
            </v-card>
          </v-col>
        </template>
        <template v-else>
          <v-col cols="12">
            <v-card color="blue-grey lighten-5" rounded="lg" max-width="599">
              <b-container
                class="d-flex justify-content-end"
                color="blue-grey lighten-5"
              >
                <v-btn text rounded outlined @click="toTop()"> close </v-btn>
              </b-container>
              <otherProfile
                :id.sync="user.id"
                :name.sync="user.name"
                :image.sync="user.image.url"
                :profile.sync="user.profile"
                :age.sync="user.age"
                :locate.sync="user.locate"
                :following.sync="user.following"
                :followers.sync="user.followers"
                :good.sync="user.goods"
                :review.sync="review"
              />
              <b-container class="d-flex justify-content-end">
                <v-btn text rounded outlined @click="createRoom">
                  <v-icon> mdi-email-outline </v-icon>
                  Chat
                </v-btn>
              </b-container>
              <b-container class="d-flex justify-content-end">
                <v-btn
                  v-if="flag"
                  text
                  rounded
                  outlined
                  small
                  @click="unfollowUser"
                >
                  unFollow
                </v-btn>
                <v-btn v-else rounded color="primary" @click="followUser">
                  Follow
                </v-btn>
              </b-container>
            </v-card>
          </v-col>
          <v-col cols="12">
            <v-card
              v-if="width > 518"
              color="blue-grey lighten-5"
              max-width="517"
            >
              <v-card-title> {{ user.name }}'sBooks </v-card-title>
              <v-container fluid>
                <v-row>
                  <v-col
                    v-for="book in books"
                    :key="book.id"
                    cols="6"
                    class="d-flex align-end"
                  >
                    <bookDetail
                      :user_id.sync="book.user_id"
                      :book_image.sync="book.book_image"
                      :comment.sync="book.comment"
                      :created_at.sync="book.created_at"
                      :google_books_api_id.sync="book.google_books_api_id"
                      :id.sync="book.id"
                      :rating.sync="book.rating"
                      :title.sync="book.title"
                      :tags.sync="book.tags"
                      :goodArray.sync="book.good"
                      :authors.sync="book.authors"
                      :publisher.sync="book.publisher"
                      :published_at.sync="book.published_at"
                    />
                  </v-col>
                </v-row>
                <v-row justify="center">
                  <v-col cols="8">
                    <v-container class="max-width">
                      <v-pagination
                        v-model="page"
                        :length="total"
                        @input="movePage"
                      >
                      </v-pagination>
                    </v-container>
                  </v-col>
                </v-row>
              </v-container>
            </v-card>
            <v-card
              v-else-if="width < 518 && width > 340"
              color="blue-grey lighten-5"
              max-width="517"
            >
              <v-card-title> {{ user.name }}'sBooks </v-card-title>
              <v-container fluid>
                <v-row>
                  <v-col
                    v-for="book in books"
                    :key="book.id"
                    cols="6"
                    class="d-flex align-end"
                  >
                    <bookDetail
                      :user_id.sync="book.user_id"
                      :book_image.sync="book.book_image"
                      :comment.sync="book.comment"
                      :created_at.sync="book.created_at"
                      :google_books_api_id.sync="book.google_books_api_id"
                      :id.sync="book.id"
                      :rating.sync="book.rating"
                      :title.sync="book.title"
                      :tags.sync="book.tags"
                      :goodArray.sync="book.good"
                      :authors.sync="book.authors"
                      :publisher.sync="book.publisher"
                      :published_at.sync="book.published_at"
                    />
                  </v-col>
                </v-row>
                <v-row justify="center">
                  <v-col cols="8">
                    <v-container class="max-width">
                      <v-pagination
                        v-model="page"
                        :length="total"
                        @input="movePage"
                      >
                      </v-pagination>
                    </v-container>
                  </v-col>
                </v-row>
              </v-container>
            </v-card>
            <v-card
              v-else
              color="blue-grey lighten-5"
              max-width="339"
              min-height="70vh"
            >
              <v-card-title> {{ user.name }}'sBooks </v-card-title>
              <v-container fluid>
                <v-row>
                  <v-col
                    v-for="book in books"
                    :key="book.id"
                    cols="12"
                    class="d-flex align-end"
                  >
                    <bookDetail
                      :user_id.sync="book.user_id"
                      :book_image.sync="book.book_image"
                      :comment.sync="book.comment"
                      :created_at.sync="book.created_at"
                      :google_books_api_id.sync="book.google_books_api_id"
                      :id.sync="book.id"
                      :rating.sync="book.rating"
                      :title.sync="book.title"
                      :tags.sync="book.tags"
                      :goodArray.sync="book.good"
                      :authors.sync="book.authors"
                      :publisher.sync="book.publisher"
                      :published_at.sync="book.published_at"
                    />
                  </v-col>
                </v-row>
                <v-row justify="center">
                  <v-col cols="8">
                    <v-container class="max-width">
                      <v-pagination
                        v-model="page"
                        :length="total"
                        @input="movePage"
                      >
                      </v-pagination>
                    </v-container>
                  </v-col>
                </v-row>
              </v-container>
            </v-card>
          </v-col>
        </template>
      </v-row>
    </v-container>
  </v-app>
</template>
<script>
import { defineComponent } from '@nuxtjs/composition-api'
import bookDetail from '~/components/books/bookDetail.vue'
import otherProfile from '~/components/profile/otherProfile.vue'
export default defineComponent({
  components: {
    otherProfile,
    bookDetail,
  },
  validate({ params }) {
    return /^\d+$/.test(params.id)
  },
  data() {
    return {
      page: 1,
      flag: false,
      presense: null,
      followSnackbar: false,
      unfollowSnackbar: false,
      error: null,
      width: window.innerWidth,
      height: window.innerHeight,
    }
  },
  async asyncData({ $axios, params }) {
    let user = []
    await $axios.$get(`/api/v1/users/${params.id}`).then((res) => (user = res))
    let books = []
    let total = null
    let review = null
    await $axios
      .$get(`/api/v1/books_shelves/user?id=${params.id}`)
      .then(
        (res) => (
          (books = res.books),
          (total = res.kaminari.pagenation.pages),
          (review = res.kaminari.pagenation.count)
        )
      )
    return { user, books, total, review }
  },
  mounted() {
    ;(this.presense = this.user.id === this.$store.state.current.user.id),
      (this.flag = this.user.followers.some(
        ({ id }) => id === this.$store.state.current.user.id
      ))
    window.addEventListener('resize', this.handleResize)
  },
  beforeDestroy: function () {
    window.removeEventListener('resize', this.handleResize)
  },
  methods: {
    toTop() {
      this.$router.back()
    },
    handleResize: function () {
      this.width = window.innerWidth
      this.height = window.innerHeight
    },
    async followUser() {
      try {
        await this.$axios
          .$post('/api/v1/relationships', {
            user_id: this.$store.state.current.user.id,
            followed_id: this.user.id,
          })
          .then(() => {
            this.flag = true
            this.followSnackbar = true
            setTimeout(() => {
              this.followSnackbar = false
            }, 1500)
            this.user.followers.push(this.$store.state.current.user)
          })
      } catch (error) {
        console.log({ error })
      }
    },
    async unfollowUser() {
      try {
        await this.$axios
          .$delete('/api/v1/relationships/delete', {
            params: {
              user_id: this.$store.state.current.user.id,
              followed_id: this.user.id,
            },
          })
          .then(() => {
            this.flag = false
            this.unfollowSnackbar = true
            setTimeout(() => {
              this.unfollowSnackbar = false
            }, 1500)
            this.user.followers.pop(this.$store.state.current.user)
          })
      } catch (error) {
        console.log({ error })
      }
    },
    async movePage(number) {
      await this.$axios
        .$get('/api/v1/books_shelves/user/', {
          params: {
            id: this.user.id,
            page: number,
          },
        })
        .then((res) => (this.books = res.books))
    },
    async createRoom() {
      await this.$axios
        .$post(`/api/v1/users/${this.user.id}/rooms`, {
          params: {
            id: this.user.id,
          },
        })
        .then((res) => this.$router.push(`/room/${res.id}`))
    },
  },
})
</script>
