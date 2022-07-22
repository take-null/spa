<template>
  <v-container fluid>
    <v-card
      flat
      tile
      color="transparent"
      max-width="768"
    >
      <v-card-title>
        本を探す
      </v-card-title>
      <v-form
        ref="form"
        v-model="isValid">
          <v-text-field
            v-model="keyword"
            clearable
            text
            label="本の名前を入力してください"
              placeholder="本を検索"
              type="text"
              :rules="rules"
              @keypress.enter.prevent="eventReady ? setBooks() : null"
            >
            <template v-slot:append>
              <v-col
                cols="12"
                sm="3"
              >
              <v-btn 
                icon
                color="indigo"
                :disabled="!isValid"
                @click.prevent="setBooks()"
              >
                <v-icon
                  large
                >
                  mdi-magnify
                </v-icon>
              </v-btn>
            </v-col>
          </template>
        </v-text-field>
      </v-form>
    </v-card>

    <v-dialog
      v-model="postMessage"
      max-width="426"
    >
      <v-card
        color="cyan lighten-4"
        >
        <v-list-item-content>
          <v-list-item-title class="text-h5 mb-1 cyan--text" >
            <v-icon>mdi-checkbox-marked-circle-plus-outline</v-icon>レビューを投稿しました！
          </v-list-item-title>
          <v-list-item-subtitle class="cyan--text">{{title}}が</v-list-item-subtitle>
          <v-list-item-subtitle class="cyan--text">本棚に追加されます。</v-list-item-subtitle>
        </v-list-item-content>
      </v-card>
    </v-dialog>

    <v-dialog v-model="dialog"  max-width="426">
      <v-card
        color="blue-grey lighten-5"
        class="mx-auto"
      >
      <v-container>
        <v-row dense>
          <v-col cols="6">
            <v-list-item-content>
              <v-list-item class="d-flex flex-column justify-content-start">
                <template v-if="image === null">
                  <img
                    height="230"
                    width="150"
                    src="@/assets/img/20200505_noimage.jpg"
                  >
                </template>
                <template v-else>
                  <v-img
                    heigth="250"
                    width="150"
                    :src="image"
                  />
                </template>
              </v-list-item>
            </v-list-item-content>
          </v-col>
          <v-col cols="6">
            <v-list-item three-line>
              <v-list-item-content class="d-flex justify-content-end">
                <div class="text-sm-h7 mb-4">
                  {{title}}
                </div>
                <v-list-item-subtitle>
                  作者:{{authors}}
                </v-list-item-subtitle>
                <v-list-item-subtitle>
                  出版社:{{publisher}}
                </v-list-item-subtitle>
                <v-list-item-subtitle>
                  出版年月日:{{published_at}}
                </v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>
          </v-col>
        </v-row>
        <v-form
          ref="form"
          v-model="isValid"
          class="pa-4 pt-6"
        >
          <v-card-subtitle>
            本を評価(５段階)
          </v-card-subtitle>
          <v-rating
            v-model="rating"
            background-color="orange lighten-3"
            color="orange"
          ></v-rating>
          <v-textarea
            ref="comment"
            :rules="[() => !!comment || 'コメントを入力して下さい']"
            v-model="comment"
            clearable
            clear-icon="mdi-close-circle"  
            label="コメントを書く"
            required
          >
          </v-textarea>
        </v-form>
      <v-divider></v-divider>
      <v-card-actions>
        <v-btn
          text
          @click="dialog = false"
        >
          close
        </v-btn>
        <v-spacer></v-spacer>
        <v-btn
          :disabled="!isValid || loading"
          :loading="loading"
          class="white--text"
          dark
          depressed
          @click.stop="postBook"
        >
          投稿
        </v-btn>
      </v-card-actions>
      </v-container>
    </v-card>
    </v-dialog>
    <v-container fluid>
      <v-row dense>
        <v-col
          v-for="book in books" :key="book.google_books_api_id"
          cols="12" sm="6" md="6" lg="4" xl="3"
        >
          <bookCard
            :google_books_api_id.sync="book.google_books_api_id"
            :publisher.sync="book.publisher"
            :title.sync="book.title"
            :authors.sync="book.authors"
            :published_at.sync="book.published_at"
            :image.sync="book.image"
            :dialog.sync="dialog"
            @openDialogParent="open"
          />
        </v-col>
      </v-row>
    </v-container>
  </v-container>
</template>
<script>
import bookCard from '~/components/books/bookCard.vue'
export default {
  components: { bookCard },
  methods: {
    async setBooks () {
      try {
        await this.$axios.get(`/api/v1/books/search?keyword=${this.keyword}`)
          .then(
            (res) => {
            this.books = []
            this.books = res.data
            console.log(res)
            const bookKeys = Object.keys(books[0] || {}) // 追加
            console.log(bookKeys)
            return { books, bookKeys }
          }
        )
        } catch (error) {
          console.log({error})
          this.error = 'データの取得に失敗しました'
          this.formReset()
        }
      },
      formReset () {
        this.$refs.form.reset()
        this.keyword = "" 
      },
      close() {
        this.dialog = false
      },
      open(google_books_api_id,publisher,title,authors,published_at,image) {
        this.dialog = true
        this.google_books_api_id = google_books_api_id
        this.publisher = publisher
        this.title = title
        this.authors = authors
        this.published_at = published_at
        this.image = image
      },
    async postBook () {
      try {
        this.loading = true
        await this.$axios.$post('/api/v1/books', {
          google_books_api_id: this.google_books_api_id
        })
        .then(
          (res) => {
          console.log(res)
        }
      )
      await this.$axios.$post('/api/v1/books_shelves', {
        comment: this.comment,
        rating: this.rating,
        google_books_api_id: this.google_books_api_id
      })
      .then(
        (res) => {
          this.loading = false
          this.dialog = false
          this.$refs.comment.reset()
          this.postMessage = true
          setTimeout(() => {
          this.postMessage = false
          }, 4000)
          console.log(res)
        }
      )
      } catch (error) {
        this.$refs.comment.reset()
        console.log({error})
      }
    },
  },
  computed: {
    eventReady() {
      if (this.keyword === '') {
        return false
      } else {
        return true
      }
    }
  },
  data () {
    const min = 1
    return {
      rating: 5,
      comment: "",
      google_books_api_id: "",
      title: "",
      publisher: "",
      authors: "",
      published_at: "",
      image: null,
      loading: false,
      isValid: false,
      dialog: false,
      postMessage: false,
      books: null,
      keyword: "",
      min,
      rules: [
        v => !!v || '',
        v => (!!v && min <= v.length) || false
      ],
      isValid: false,
      loading: false,
    }
  },
}
</script>