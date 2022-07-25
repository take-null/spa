<template>
  <v-card
    class="mx-auto"
    max-width="425"
    color="blue-grey lighten-5"
  >
    <v-container
      fluid
    >
      <v-row>
        <v-col
          cols="7"
        >
          <v-card-text>
            <div>{{created_at}}前</div>
              <p class="text-subtitle-1 text--primary">
               【{{title}}】
              </p>
                <v-row
                  dense
                >
                  <p>投稿者</p>
                <v-col
                  cols="3"
                >
                  <v-card-actions>
                    <v-btn
                      icon
                      @click="toShowChild(user_id)"
                    >
                      <v-list-item-avatar
                        size="50"
                        class="d-flex justify-content-start"
                      >
                        <template v-if="user_image === null">
                          <v-icon x-large>
                            mdi-account-circle
                          </v-icon>
                        </template>
                        <template v-else>
                          <v-img :src="`http://localhost:3000/${user_image}`" alt="avatar" />
                        </template>
                      </v-list-item-avatar>
                    </v-btn>
                  </v-card-actions>
                </v-col>
                <v-col
                  cols="9"
                >
                  <v-list-item
                    class="d-flex justify-content-start"
                  >
                    <v-card-text class="pb-0">
                      <p 
                        class="text-body-1 text--primary"
                      >
                        {{user_name}}
                      </p>
                    </v-card-text>                
                  </v-list-item>
                </v-col>
              </v-row>
          </v-card-text>
        </v-col>
        <v-col cols="5">
                  <v-list-item-content>
                    <v-list-item class="d-flex flex-column justify-content-start">
                      <template v-if="book_image === null">
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
                          :src="book_image"
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
                          v-model="rating"
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
                          {{comment}}
                        </p>
                      </v-card-text>
                    </v-list-item>
                  </v-row>
              </v-container>
          </v-card>
      </v-expand-transition>
  </v-card>
</template>


<script>
export default {
  props: {
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
    user_id: {
        type: Number
    },
    user_image: {
      type: String
    },
    user_name: {
      type: String
    }
  },
  methods: {
    toShowChild() {
      this.$emit(
        'toShowParent', 
        this.user_id,
      )
    }
  },
  data () {
    return {
      reveal: false
    }
  },
}
</script>

<style>
.v-card--reveal {
  bottom: 0;
  opacity: 1 !important;
  position: absolute;
  width: 100%;
}
</style>