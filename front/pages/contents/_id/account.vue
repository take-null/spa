<template>
  <v-app 
    id="inspire"
  >
    <v-container
      fluid
    >
      <v-row>
        <template 
          v-if="width > 600"
        >
          <v-col
            cols="3"
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
                :good.sync="user.goods"
                :review.sync="review"
              />
            </v-card>
          </v-col>
          <v-col
            cols="9"
          >
            <v-card
              v-if="width > 600 && width <768"
              color="blue-grey lighten-5"
              max-width="600"
            >
              <v-card-title>
                MyBooks
              </v-card-title>
              <v-container 
                fluid
              >
                <v-row>
                  <v-col
                    v-for="book in books" :key="book.id"
                    cols="4"
                    class="d-flex align-end"
                  >
                    <bookDetail 
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
                      @checkParent="redirectPage"
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
                MyBooks
              </v-card-title>
              <v-container 
                fluid
              >
                <v-row>
                  <v-col
                    v-for="book in books" :key="book.id"
                    cols="12" sm="4" md="3" lg="3" xl="2"
                    class="d-flex align-end"
                  >
                    <bookDetail 
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
                      @checkParent="redirectPage"
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
        <template 
          v-else
        >
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
              :good.sync="user.goods"
              :review.sync="review"
            />
          </v-card>
        </v-col>
        <v-col
          cols="12"
        >
          <v-card
            v-if="width > 518"
            color="blue-grey lighten-5"
            max-width="517"  
          >
            <v-card-title>
              MyBooks
            </v-card-title>
              <v-container 
                fluid
              >
                <v-row>
                  <v-col
                    v-for="book in books" :key="book.id"
                      cols="6"
                      class="d-flex align-end"
                  >
                    <bookDetail 
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
                      @checkParent="redirectPage"
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
              v-else-if="width < 518 && width > 340"
              color="blue-grey lighten-5"
              max-width="517"  
            >
              <v-card-title>
                MyBooks
              </v-card-title>
              <v-container 
                fluid
              >
                <v-row>
                  <v-col
                    v-for="book in books" :key="book.id"
                    cols="6"
                    class="d-flex align-end"
                  >
                    <bookDetail 
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
                      @checkParent="redirectPage"
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
              max-width="339"
              min-height="70vh"
            >
              <v-card-title>
                MyBooks
              </v-card-title>
              <v-container 
                fluid
              >
                <v-row>
                  <v-col
                    v-for="book in books" :key="book.id"
                    cols="12"
                    class="d-flex align-end"
                  >
                    <bookDetail 
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
                      @checkParent="redirectPage"
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
import bookDetail from '~/components/books/bookDetail.vue'
import myProfile from '~/components/profile/myProfile.vue'
export default {
  components: { 
    myProfile,
    bookDetail
  },
  data () {
    return {
      page: 1,
      width: window.innerWidth,
      height: window.innerHeight
    }
  },
  async asyncData ({ $axios, $nxauth }) {
    let user = []
    await $axios.$get(`/api/v1/users/${$nxauth.user.id}`)
    .then((res) => (
      user = res
    ))
    let books = []
    let total = null
    let review = null
    await $axios.$get('/api/v1/books_shelves/')
    .then(res => (
      books = res.books,
      total = res.kaminari.pagenation.pages,
      review = res.kaminari.pagenation.count
    ))
    return { user, books, total, review }
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
    },
    async movePage(number) {
      await this.$axios.$get('/api/v1/books_shelves/', {
        params: {
          page: number, 
        },
      })
      .then((res) => (
        this.books = res.books
      ))
    },
    redirectPage() {
      this.$router.go({path: this.$router.currentRoute.path, force: true})
    }
  },
};
</script>