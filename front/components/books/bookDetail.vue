<template>
  <v-row 
    justify="center"
  >
    <v-dialog
      v-model="dialog"
      fullscreen
      transition="dialog-bottom-transition"
    >
      <template 
        v-slot:activator="{ on, attrs }" 
      >
        <v-card
          color="blue-grey lighten-5"
          max-width="140"
          v-bind="attrs"
          v-on="on"
          elevation="0"
        >
          <template 
            v-if="book_image === null"
          >
            <v-img
              max-height="230"
              :src="require('@/assets/img/20200505_noimage.jpg')"
            />
          </template>
          <template 
            v-else
          >
            <v-img 
              :src="book_image"
              max-heigth="230"
            />
          </template>
        </v-card>
      </template>
      <v-sheet
        class="mx-auto"
        max-width="max-width"
        color="blue-grey lighten-5"
        title
        rounded-0
        elevation="1"
        min-height="100vh"
      >
        <v-toolbar
          dark
        >
          <v-btn
            icon
            dark
            @click="dialog = !dialog"
          >
            <v-icon>
              mdi-close
            </v-icon>
          </v-btn>
          <v-toolbar-title>
            BookDetail
          </v-toolbar-title>
          <v-spacer></v-spacer>
          <template
            v-if="$store.state.current.user.id === user_id"
          >
            <v-btn
              text
              rounded
              outlined
              small
              @click="modal = true"
            >
              delete
            </v-btn>
              <v-snackbar
                v-model="modal"
                max-width="400"
                absolute
                outlined
                text
                top
              >
                <p
                  class="text-body-2 white--text" 
                >
                  この投稿データを削除しますか？
                </p>
              <template 
                v-slot:action="{ attrs }"
              >
                <v-btn
                  text
                  rounded
                  outlined
                  small
                  v-bind="attrs"
                  @click.stop="deleteContent(id)"
                >
                  yes
                </v-btn>
              </template>  
            </v-snackbar>
          </template>
        </v-toolbar>
          <v-container
            fluid
          >
            <div
              class="text-sm-h7 mb-4"
            >
              {{day}}前
            </div>
            <v-row
              no-gutters
            >
              <v-col>
                <v-list-item 
                  class="justify-content-start"
                >
                  <template 
                    v-if="book_image === null"
                  >
                    <v-img
                      max-height="160"
                      max-width="120"
                      :src="require('@/assets/img/20200505_noimage.jpg')"
                    />
                  </template>
                  <template 
                    v-else
                  >
                    <v-img
                      max-heigth="160"
                      max-width="120"
                      :src="book_image"
                    />
                  </template>
              </v-list-item>
              <v-list-item 
                class="justify-content-start"
              >
                <v-rating
                  v-model="rating"
                  background-color="orange lighten-3"
                  color="orange"
                  x-small
                ></v-rating>
              </v-list-item>
            </v-col>
            <v-col>
              <v-list-item 
                three-line
              >
                <v-list-item-content 
                  class="d-flex justify-content-start"
                >
                  <div 
                    class="text-sm-h7 mb-4"
                  >
                    {{title}}
                  </div>
                  <v-list-item-subtitle 
                    v-if="authors === null" 
                    class="mb-2"
                  >
                    作者:{{authors}}
                  </v-list-item-subtitle>
                  <v-list-item-subtitle 
                    v-else class="mb-2"
                  >
                    作者:{{authors.name}}
                  </v-list-item-subtitle>
                  <v-list-item-subtitle 
                    class="mb-2"
                  >
                    出版社:{{publisher}}
                  </v-list-item-subtitle>
                  <v-list-item-subtitle 
                    class="mb-2"
                  >
                    出版年月日:{{published_at}}
                  </v-list-item-subtitle>
                  <template 
                    v-if="goodArray.length === 0"
                  >
                    <v-list-item-avatar
                      size="60"
                    >
                      <v-icon
                        color="cyan"
                      >
                        mdi-thumb-up
                      </v-icon>
                      <p
                        class="text-caption"
                      >
                        {{ 0 }}
                      </p>
                    </v-list-item-avatar>
                  </template>
                  <template 
                    v-else
                  >
                    <v-list-item-avatar
                      size="60"
                    >
                      <v-icon
                        color="cyan"
                      >
                        mdi-thumb-up
                      </v-icon>
                      <p
                        class="text-caption"
                      >
                        {{ goodArray.length }}
                      </p>
                    </v-list-item-avatar>
                  </template>
                </v-list-item-content>
              </v-list-item>
            </v-col>
          </v-row>
        </v-container>
        <v-container
          fluid
          mt-n2 pt-0
        >
          <v-list-item-content>
            <v-list-item-title
              class="text-body-2 text--primary wrap-text" 
            >
              UserReview
            </v-list-item-title>
            <v-list-item-subtitle
              class="text-body-2 text--primary wrap-text"
            >
              <perfect-scrollbar>
                {{comment}}
              </perfect-scrollbar>
            </v-list-item-subtitle>
          </v-list-item-content>
        </v-container>
        <v-container
          fluid
          mt-n2 pt-0
        >
          <v-row
            no-gutters
          >
            <div 
              class="text-body-2 text--primary"
            >
              Tags
            </div>
            <template 
              v-if="tags.length"
            >
              <v-col
                v-for="tag in tags" :key="tag.id"
                cols="2"
              >
                <p
                  class="text-overline text--cyan"
                >
                  #{{tag.name}}
                </p>
              </v-col>
            </template>
            <template 
              v-else
            >
              <p
                class="text-overline text--cyan"
              >
                登録されているタグはありません
              </p>
            </template>
          </v-row>
        </v-container>
      </v-sheet>
    </v-dialog>
  </v-row>
</template>

<script>
import { formatDistanceToNow } from 'date-fns'
import { ja } from 'date-fns/locale'
import { PerfectScrollbar } from 'vue2-perfect-scrollbar'
import 'vue2-perfect-scrollbar/dist/vue2-perfect-scrollbar.css'
export default {
  components: { 
    PerfectScrollbar 
  },
  props: {
    user_id: {
      tupe: Number
    },
    book_image: {
      type: String
    },
    comment: {
      type: String
    },
    created_at: {
      type: String
    },
    google_books_api_id: {
      type: String
    },
    id: {
      type: Number
    },
    rating: {
      type: Number
    },
    title: {
      type: String
    },
    tags: {
      type:Array
    },
    goodArray: {
      type:Array
    },
    authors: {
      type: Object  
    },
    publisher: {
      type: String
    },
    published_at: {
      type: String
    },
  },
  data () {
    return {
      modal: false,
      dialog: false,
      day: formatDistanceToNow(new Date(this.created_at), { locale: ja })
    }
  },
  methods: {
    async deleteContent(id) {
      await this.$axios.$delete(`/api/v1/books_shelves/${id}`)
      .then(() => {
        this.modal = false
        this.dialog = false
        this.$emit('checkParent')
      })
    }
  }
}
</script>

<style>
.v-card--reveal {
  bottom: 0;
  opacity: 1 !important;
  position: absolute;
  width: 100%;
}

.wrap-text {
  word-break: break-all;
  white-space: pre-line;
}
.ps {
  height: 200px;
  border: 1px solid #212121;
}
</style>