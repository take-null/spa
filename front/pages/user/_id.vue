<template>
<v-app id="inspire">
  <v-container
    fluid
  > 
    <v-row
      dense
    >
      <template v-if="width > 600">
      <v-col
        cols="4"
      >
        <v-card
          color="blue-grey lighten-5"
          rounded="lg"
          max-width="600"
          min-height="70vh"
        >
          <v-snackbar
            v-model="followSnackbar"
            max-width="768"
            color="primary"
            absolute
            outlined
            text
            top
          >
            <p class="font-italic"><v-icon>mdi-checkbox-marked-circle-plus-outline</v-icon>{{user.name}}をフォローしました</p>
          </v-snackbar>
          <v-snackbar
            v-model="unfollowSnackbar"
            max-width="768"
            color="primary"
            absolute
            outlined
            text
            top
          >
            <p class="font-italic"><v-icon>mdi-checkbox-marked-circle</v-icon>{{user.name}}のフォローを解除しました</p>
          </v-snackbar>
          <b-container class="d-flex justify-content-end" color="blue-grey lighten-5">
            <v-btn
              text
              rounded
              outlined
              @click="toTop()"
            >
              close
            </v-btn>
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
            />
            <b-container class="d-flex justify-content-end">
              <v-btn v-if="flag"
                text
                outlined
                @click="unfollowUser"
              >
                <v-icon>mdi-checkbox-marked-circle</v-icon>
                unFollow
              </v-btn>
              <v-btn v-else
                color="cyan accent-3"
                class="white--text"
                @click="followUser"
              >
                <v-icon>mdi-checkbox-marked-circle-plus-outline</v-icon>
                Follow
              </v-btn>
            </b-container>
          </v-card>
        </v-col>
        <v-col
          cols="8">
            <v-card
              v-if="width > 600 && width <768"
              color="blue-grey lighten-5"
              max-width="960"
            >
              <v-card-title>
                {{user.name}}の本棚
              </v-card-title>
              <v-container fluid>
                <v-row dense>
                  <v-col
                    v-for="book in books" :key="book.id"
                      cols="4"
                      class="d-flex align-end"
                  >
                    <v-img
                      contain 
                      :src="book.book_image"
                      heigth="230"
                      width="140"
                     />
                  </v-col>
                </v-row>
                <v-row
                  justify="center"
                >
                  <v-col
                    cols="8"
                  >
                    <v-container
                      class="max-width"
                    >
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
              max-width="960"
            >
              <v-card-title>
                {{user.name}}の本棚
              </v-card-title>
            <v-container fluid>
              <v-row dense>
                <v-col
                  v-for="book in books" :key="book.id"
                  cols="12" sm="3" md="2" lg="2" xl="2"
                  class="d-flex align-end"
                >
                  <v-img
                    contain 
                    :src="book.book_image"
                    heigth="230"
                    width="140"
                  />
                </v-col>
              </v-row>
                            <v-row
                  justify="center"
                >
                  <v-col
                    cols="8"
                  >
                    <v-container
                      class="max-width"
                    >
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
        <v-col
          cols="12"
        >
        <v-card
          color="blue-grey lighten-5"
          rounded="lg"
          max-width="599"
        >
          <v-snackbar
            v-model="followSnackbar"
            max-width="426"
            color="primary"
            absolute
            outlined
            text
            top
          >
            <p class="font-italic"><v-icon>mdi-checkbox-marked-circle-plus-outline</v-icon>{{user.name}}をフォローしました</p>
          </v-snackbar>
          <v-snackbar
            v-model="unfollowSnackbar"
            max-width="426"
            color="primary"
            absolute
            outlined
            text
            top
          >
            <p class="font-italic"><v-icon>mdi-checkbox-marked-circle</v-icon>{{user.name}}のフォローを解除しました</p>
          </v-snackbar>
          <b-container class="d-flex justify-content-end" color="blue-grey lighten-5">
            <v-btn
              text
              rounded
              outlined
              @click="toTop()"
            >
              close
            </v-btn>
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
            />
            <b-container class="d-flex justify-content-end">
              <v-btn v-if="flag"
                text
                outlined
                @click="unfollowUser"
              >
                <v-icon>mdi-checkbox-marked-circle</v-icon>
                unFollow
              </v-btn>
              <v-btn v-else
                color="cyan accent-3"
                class="white--text"
                @click="followUser"
              >
                <v-icon>mdi-checkbox-marked-circle-plus-outline</v-icon>
                Follow
              </v-btn>
            </b-container>
          </v-card>
        </v-col>
        <v-col
          cols="12">
            <v-card
              v-if="width < 429"
              color="brown lighten-5"
              max-width="599"
              
            >
              <v-card-title>
                {{user.name}}の本棚
              </v-card-title>
              <v-container fluid>
                <v-row dense>
                  <v-col
                    v-for="book in books" :key="book.id"
                      cols="4"
                      class="d-flex align-end"
                  >
                    <v-img
                      contain 
                      :src="book.book_image"
                      heigth="230"
                      width="140"
                     />
                  </v-col>
                </v-row>
                              <v-row
                  justify="center"
                >
                  <v-col
                    cols="8"
                  >
                    <v-container
                      class="max-width"
                    >
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
              color="brown lighten-5"
              max-width="599"
              min-height="70vh"
            >
            <v-card-title>
              {{user.name}}の本棚
            </v-card-title>
            <v-container fluid>
              <v-row dense>
                <v-col
                  v-for="book in books" :key="book.id"
                  cols="3"
                  class="d-flex align-end"
                >
                  <v-img
                    contain 
                    :src="book.book_image"
                    heigth="230"
                    width="140"
                  />
                </v-col>
              </v-row>
                            <v-row
                  justify="center"
                >
                  <v-col
                    cols="8"
                  >
                    <v-container
                      class="max-width"
                    >
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
import otherProfile from '~/components/profile/otherProfile.vue'
export default defineComponent({
  components: {
    otherProfile,
  },
  validate({ params }) {
    return /^\d+$/.test(params.id)
  },
  computed: {
    isPerson () {
      return this.$store.state.current.user
    }
  },
  data () {
    return {
      page: 1,
      flag: false,
      followSnackbar: false,
      unfollowSnackbar: false,
      error: null,
      width: window.innerWidth,
      height: window.innerHeight
    }
  },
  async asyncData ({ $axios, params }) {
    let user = []
    await $axios.$get(`/api/v1/users/${params.id}`).then((res) => (
    user = res,
    console.log(user)
    ))
    let books = []
    let total = null
    await $axios.$get(`/api/v1/books_shelves/user?id=${params.id}`).then(res => (
    books = res.books,
    total = res.kaminari.pagenation.pages,
    console.log(books)))
    const bookKeys = Object.keys(books[0] || {})
    console.log(bookKeys)
    return { user, books, bookKeys, total }
  },
  mounted() {
    this.flag = this.user.followers.some(({id}) => id === this.$store.state.current.user.id)
    window.addEventListener('resize', this.handleResize)
  },
  beforeDestroy: function () {
    window.removeEventListener('resize', this.handleResize)
  },
  methods: {
    toTop() {
      this.$router.back()
    },
    handleResize: function() {
      this.width = window.innerWidth;
      this.height = window.innerHeight;
    },
    async followUser () {
    try {
      await this.$axios.$post('/api/v1/relationships', {
        user_id: this.$store.state.current.user.id, 
        followed_id: this.user.id
      })
      .then(
        (res) => {
        this.flag = true
        this.followSnackbar = true
        setTimeout(() => {
        this.followSnackbar = false
        }, 1500)
        console.log(res)
        this.user.followers.push(this.$store.state.current.user);
        console.log(this.user)
      }
    )
    //いらないかも
    await this.$axios.$get(`/api/v1/users/${this.user.id}`)
    .then(
      (res) => {
        console.log(res)
      }
    )
    } catch (error) {
      console.log({error})
    }
  },
  async unfollowUser () {
    try {
      await this.$axios.$delete('/api/v1/relationships/delete', {
        params: {
          user_id: this.$store.state.current.user.id, 
          followed_id: this.user.id,
        },
      })
      .then(
        (res) => {
        this.flag = false
        this.unfollowSnackbar = true
        setTimeout(() => {
        this.unfollowSnackbar = false
        }, 1500)
        console.log(res)
        this.user.followers.pop(this.$store.state.current.user);
        console.log(this.user)
      }
    )
    //いらないかも
    await this.$axios.$get(`/api/v1/users/${this.user.id}`)
    .then(
      (res) => {
          console.log(res)
        }
      )
         } catch (error) {
           console.log({error})
         }
       },
      async movePage({number}) {
      await this.$axios.$get(`/api/v1/books_shelves/user?id=${this.user.id}`, {
        params: {
          page: number, 
        },
      }).then(res => (
      this.books = res.books,
      console.log(res),
      console.log(res.books)))
    }
    },

  },
);
</script>