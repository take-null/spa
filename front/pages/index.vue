<template>
  <v-app id="inspire">
      <v-container
        class="py-8 px-6"
        fluid
      >
        <v-row>
          <v-col
            v-for="book in formattedBooks"
            :key="book.id"
            cols="12"
          >
            <v-card
              class="mx-auto"
              max-width="425"
            >
            <v-container
              fluid
            >
              <v-row
                dense>
                <v-col
                  cols="6"
                >
                  <v-card-text>
                    <div>{{book.created_at}}前</div>
                    <p class="text-subtitle-1 text--primary">
                      【{{book.title}}】
                    </p>
                    <v-row
                      dense
                    >
                      <p>投稿者</p>
                      <v-col
                        cols="2"
                      >
                        <v-list-item-avatar
                          size="50"
                          class="d-flex justify-content-start"
                        >
                          <template v-if="book.user_image === null">
                            <v-icon x-large>
                              mdi-account-circle
                            </v-icon>
                          </template>
                          <template v-else>
                            <v-img :src="`http://localhost:3000/${book.user_image}`" alt="avatar" />
                          </template>
                        </v-list-item-avatar>
                      </v-col>
                      <v-col
                        cols="10"
                      >
                        <v-list-item
                          class="d-flex justify-content-start"
                        >
                          <v-card-text class="pb-0">
                            <p 
                              class="text-subtitle-1 text--primary"
                            >
                              {{book.user_name}}
                            </p>
                          </v-card-text>                
                        </v-list-item>
                      </v-col>
                    </v-row>

                  </v-card-text>
                </v-col>
                <v-col cols="6">
                  <v-list-item-content>
                    <v-list-item class="d-flex flex-column justify-content-start">
                      <template v-if="book.book_image === null">
                        <img
                          height="140"
                          width="100"
                          src="@/assets/img/20200505_noimage.jpg"
                        >
                      </template>
                      <template v-else>
                        <v-img
                          heigth="140"
                          width="100"
                          :src="book.book_image"
                        />
                      </template>
                    </v-list-item>
                    <v-list-item class="d-flex justify-content-end">
                      <v-btn
                        text
                        outlined
                        rounded
                        @click="reveal = true"
                      >
                        Review
                      </v-btn>
                    </v-list-item>
                  </v-list-item-content>
                </v-col>
              </v-row>
            </v-container>
              <v-expand-transition>
                <v-card
                  v-if="reveal"
                  class="transition-fast-in-fast-out v-card--reveal"
                  style="height: 100%;"
                >
                  <v-container
                    fluid
                  >
                    <v-row
                      dense
                    >
                      <v-col
                        cols="2"
                      >
                        <p 
                          class="text-subtitle-2 text--primary"
                        >
                          評価:
                        </p>
                      </v-col>
                      <v-col
                        cols="7"
                      >
                        <v-rating
                          v-model="book.rating"
                          background-color="orange lighten-3"
                          color="orange"
                          x-small
                        ></v-rating>
                      </v-col>
                      <v-col
                        cols="3"
                      >
                        <v-list-item class="d-flex justify-content-end">
                          <v-btn
                            text
                            outlined
                            rounded
                            @click="reveal = false"
                          >
                            <v-icon>
                              mdi-refresh
                            </v-icon>
                          </v-btn>
                        </v-list-item>
                      </v-col>
                      </v-row>
                      <v-row>
                        <p class="text-subtitle-2 text--primary">レビュー:</p>
                      <v-list-item>
                        <v-card-text class="pb-0">
                          <p class="text-subtitle-2 text--primary">
                            {{book.commnet}}
                          </p>
                        </v-card-text>
                      </v-list-item>
                    </v-row>
                  </v-container>
                </v-card>
              </v-expand-transition>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
  </v-app>
</template>

<script>
import { formatDistanceToNow } from 'date-fns'
import { ja } from 'date-fns/locale'
export default {
  layout ({ $nxauth }) {
    return $nxauth.loggedIn ? 'loggedIn' : 'welcome'
  },
  async asyncData ({ $axios }) {
    let books = []
    await $axios.$get(`/api/v1/books_shelves/all`).then(res => (
    console.log(res),
    books = res,
    console.log(books)))
    const formattedBooks = books.map(book => {let time = formatDistanceToNow(new Date(book.created_at), { locale: ja })
        return { ...book, created_at: time }
    })
    const bookKeys = Object.keys(books || {}) // 追加
    console.log(bookKeys)
    return { formattedBooks, bookKeys }
  },
  data: () => ({
    reveal: false,
  }),
};
</script>

<style>
.v-card--reveal {
  bottom: 0;
  opacity: 1 !important;
  position: absolute;
  width: 100%;
}
</style>