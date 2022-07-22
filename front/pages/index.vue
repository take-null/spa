<template>
  <v-app id="inspire">
    <v-system-bar app>
      <v-spacer></v-spacer>

      <v-icon>mdi-square</v-icon>

      <v-icon>mdi-circle</v-icon>

      <v-icon>mdi-triangle</v-icon>
    </v-system-bar>

    <v-navigation-drawer
      v-model="drawer"
      app
    >
      <v-sheet
        color="grey lighten-4"
        class="pa-4"
      >
        <v-avatar
          class="mb-4"
          color="grey darken-1"
          size="64"
        ></v-avatar>

        <div>john@vuetifyjs.com</div>
      </v-sheet>

      <v-divider></v-divider>

      <v-list>
        <v-list-item
          v-for="[icon, text] in links"
          :key="icon"
          link
        >
          <v-list-item-icon>
            <v-icon>{{ icon }}</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>{{ text }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>

    <v-main>
      <v-container
        class="py-8 px-6"
        fluid
      >
        <v-row>
          <v-col
            v-for="book in books"
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
              <v-row>
                <v-col
                  cols="6"
                >
              <v-card-text>
                <div>{{book.created_at}}</div>
                <p class="text-h5 text--primary">
                  {{book.title}}
                </p>
                <p>          
                  <v-rating
                    v-model="book.rating"
                    background-color="orange lighten-3"
                    color="orange"
                    ></v-rating>
                </p>
              </v-card-text>
              <v-card-actions>
                <v-btn
                  text
                  color="teal accent-4"
                  @click="reveal = true"
                >
                  More
                </v-btn>
              </v-card-actions>
                </v-col>
                <v-col cols="6">
                  <v-list-item-content>
                    <v-list-item class="d-flex flex-column justify-content-start">
                      <template v-if="book.book_image === null">
                        <img
                          height="200"
                          width="120"
                          src="@/assets/img/20200505_noimage.jpg"
                        >
                      </template>
                      <template v-else>
                        <v-img
                          heigth="200"
                          width="120"
                          :src="book.book_image"
                        />
                      </template>
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
                <v-list-item>
                  <v-card-text class="pb-0">
                    <p class="text-h5 text--primary">
                      {{book.user_name}}
                    </p>
                  </v-card-text>
                  <v-card-text class="pb-0">
                    <p class="text-h5 text--primary">
                      {{book.commnet}}
                    </p>
                  </v-card-text>
                  
                    <v-list-item-avatar
                      tile
                      size="80"
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
                  </v-list-item>
                  <v-card-actions class="pt-0">
                    <v-btn
                      text
                      color="teal accent-4"
                      @click="reveal = false"
                    >
                      Close
                    </v-btn>
                  </v-card-actions>
                </v-card>
              </v-expand-transition>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
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
    const bookKeys = Object.keys(books[0] || {}) // 追加
    console.log(bookKeys)
    return { books, bookKeys }
  },
  data: () => ({
    drawer: null,
    reveal: false,
    links: [
      ['mdi-inbox-arrow-down', 'Inbox'],
      ['mdi-send', 'Send'],
      ['mdi-delete', 'Trash'],
      ['mdi-alert-octagon', 'Spam'],
    ],
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