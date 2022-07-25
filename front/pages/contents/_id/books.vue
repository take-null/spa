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
        <v-row>
        <v-form
          ref="form"
          v-model="isValid"
          class="pa-4 pt-0"
        >
          <v-card-subtitle>
            本を評価(５段階)
          </v-card-subtitle>
          <v-rating
            v-model="rating"
            background-color="orange lighten-3"
            color="orange"
            x-small
          ></v-rating>
          <v-card-subtitle>
            タグを追加(５つまで)
          </v-card-subtitle>
            <v-combobox
              v-model="model"
              :filter="filter"
              :hide-no-data="!search"
              :items="items"
              :search-input.sync="search"
              hide-selected
              label="先頭から最大５つまで、タグが登録されます"
              multiple
              small-chips
              solo
              >
              <template v-slot:no-data>
                <v-list-item>
                  <span class="subheading">Create</span>
                    <v-chip
                      :color="`${colors[nonce - 1]} lighten-3`"
                      label
                      small
                    >
                      {{ search }}
                    </v-chip>
                </v-list-item>
              </template>
              <template v-slot:selection="{ attrs, item, parent, selected }">
                <v-chip
                  v-if="item === Object(item)"
                    v-bind="attrs"
                    :color="`${item.color} lighten-3`"
                    :input-value="selected"
                    label
                    small
                >
                  <span class="pr-2">
                    {{ item.text }}
                  </span>
                  <v-icon
                    small
                    @click="parent.selectItem(item)"
                  >
                    $delete
                  </v-icon>
              </v-chip>
              </template>
              <template v-slot:item="{ index, item }">
                <v-text-field
                  v-if="editing === item"
                  v-model="editing.text"
                  autofocus
                  flat
                  background-color="transparent"
                  hide-details
                  solo
                  @keyup.enter="edit(index, item)"
                ></v-text-field>
                <v-chip
                  v-else
                  :color="`${item.color} lighten-3`"
                  dark
                  label
                  small
                >
                  {{ item.text }}
                </v-chip>
                <v-spacer></v-spacer>
                <v-list-item-action @click.stop>
                  <v-btn
                    icon
                    @click.stop.prevent="edit(index, item)"
                  >
                  <v-icon>{{ editing !== item ? 'mdi-pencil' : 'mdi-check' }}</v-icon>
                  </v-btn>
                </v-list-item-action>
              </template>
            </v-combobox>
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
        </v-row>
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
    createParams () {
      var count = 0;
      for(var i = 0; i <= this.model.length - 1; i++ ) {
      this.params.push(this.model[i].text)
      if(count > 4) break;
      console.log(this.params)
      }
    },
    edit (index, item) {
      if (!this.editing) {
        this.editing = item
        this.editingIndex = index
      } else {
        this.editing = null
        this.editingIndex = -1
      }
    },
    filter (item, queryText, itemText) {
      if (item.header) return false
      const hasValue = val => val != null ? val : ''
      const text = hasValue(itemText)
      const query = hasValue(queryText)
      return text.toString()
        .toLowerCase()
        .indexOf(query.toString().toLowerCase()) > -1
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
      params: [],
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
      activator: null,
      attach: null,
      colors: ['green', 'purple', 'indigo', 'cyan', 'teal', 'orange'],
      editing: null,
      editingIndex: -1,
      items: [
        {
          text: 'Foo',
          color: 'blue',
        },
        {
          text: 'Bar',
          color: 'red',
        },
      ],
      nonce: 1,
      menu: false,
      model: [
      ],
      x: 0,
      search: null,
      y: 0,
    }
  },
  watch: {
    model (val, prev) {
      if (val.length === prev.length) return
      this.model = val.map(v => {
        if (typeof v === 'string') {
          v = {
            text: v,
            color: this.colors[this.nonce - 1],
          }
          this.items.push(v)
          this.nonce++
        }
        return v
      })
    },
  },
}
</script>