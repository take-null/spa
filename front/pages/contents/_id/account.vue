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
            <myProfile
              :name.sync="user.name"
              :image.sync="user.image.url"
              :email.sync="user.email" 
              :profile.sync="user.profile" 
              :age.sync="user.age" 
              :locate.sync="user.locate"
              :following.sync="user.following"
              :followers.sync="user.followers"
            />
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
                私の本棚
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
              </v-container>
            </v-card>
            <v-card
              v-else
              color="blue-grey lighten-5"
              max-width="960"
            >
              <v-card-title>
                私の本棚
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
            <myProfile
              :name.sync="user.name"
              :image.sync="user.image.url"
              :email.sync="user.email" 
              :profile.sync="user.profile" 
              :age.sync="user.age" 
              :locate.sync="user.locate"
              :following.sync="user.following"
              :followers.sync="user.followers"
            />
          </v-card>
        </v-col>
        <v-col
          cols="12">
            <v-card
              v-if="width < 429"
              color="blue-grey lighten-5"
              max-width="599"
              
            >
              <v-card-title>
                私の本棚
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
              </v-container>
            </v-card>
            <v-card
              v-else
              color="blue-grey lighten-5"
              max-width="599"
              min-height="70vh"
            >
            <v-card-title>
              私の本棚
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
            </v-container>
          </v-card>
        </v-col>
        </template>
      </v-row>
    </v-container>
  </v-app>
</template>

<script>
import myProfile from '~/components/profile/myProfile.vue'
export default {
  components: { 
    myProfile 
  },
  data () {
    return {
      dialog: false,
      show: false,
      width: window.innerWidth,
      height: window.innerHeight
    }
  },
  async asyncData ({ $axios, $nxauth }) {
    let user = []
    await $axios.$get(`/api/v1/users/${$nxauth.user.id}`).then((res) => (
    user = res,
    console.log(user)
    ))
    let books = []
    await $axios.$get(`/api/v1/books_shelves/user?id=${$nxauth.user.id}`).then(res => (
    books = res,
    console.log(books)))
    const bookKeys = Object.keys(books[0] || {})
    console.log(bookKeys)
    return { user, books, bookKeys }
  },
  mounted() {
    window.addEventListener('resize', this.handleResize)
  },
  beforeDestroy: function () {
    window.removeEventListener('resize', this.handleResize)
  },
  methods: {
    handleResize: function() {
      this.width = window.innerWidth;
      this.height = window.innerHeight;
    }
  }
};
</script>