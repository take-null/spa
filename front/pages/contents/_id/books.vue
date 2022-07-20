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
    
    <v-container fluid>
      <v-row dense >
        <v-col
          v-for="book in books" :key="book.google_books_api_id"
          cols="12" sm="6" md="4" lg="3" xl="3"
        >
          <book-card
            :google_books_api_id.sync="book.google_books_api_id"
            :publisher.sync="book.publisher"
            :title.sync="book.title"
            :authors.sync="book.authors"
            :published_at.sync="book.published_at"
            :image.sync="book.image"
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
      }
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
      books: [],
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