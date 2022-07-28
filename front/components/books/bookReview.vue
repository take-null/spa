<template>
  <v-card
    class="mx-auto"
    max-width="425"
    color="blue-grey lighten-5"
  >
    <v-container
      fluid
    >
      <v-row
        no-gutters
      >
        <v-col
          cols="7"
        >
          <v-card-text>
            <p>
              {{created_at}}前
            </p>
            <p 
              class="text-body-1 text--primary"
            >
             【{{title}}】
            </p>
          </v-card-text>
          <v-row
            dense
          >
            <v-col
              cols="3"
            >                
              <v-card-actions>
                <v-btn
                  icon
                  @click="toShowChild(user_id)"
                >
                  <v-avatar
                    size="50"
                    class="d-flex justify-content-center"
                  >
                    <template v-if="user_image === null">
                      <v-icon 
                        x-large
                      >
                        mdi-account-circle
                      </v-icon>
                    </template>
                    <template v-else>
                      <v-img :src="`http://localhost:3000/${user_image}`" alt="avatar" />
                    </template>
                  </v-avatar>
                </v-btn>
              </v-card-actions>
            </v-col>
            <v-col
              cols="7"
            >
              <p 
                class="text-text-body-2 text--primary"
              >
                {{user_name}}
              </p>
            </v-col>
          </v-row>
          <v-card-actions>
            <v-container
              fluid
            >
              <v-row
                no-gutters
              >
                <v-col
                  v-for="tag in tags" :key="tag.id"
                >
                  <v-btn
                    text
                    x-small
                    @click.stop="searchTagChild(tag.name)"
                  >
                    <p
                      class="text-overline text--primary"
                    >
                      <v-icon>
                        mdi-label
                      </v-icon>
                        {{tag.name}}
                    </p>
                  </v-btn>
                </v-col>
              </v-row>
            </v-container>
          </v-card-actions>
        </v-col>
        <v-col cols="5">
          <v-list-item-content>
            <v-list-item class="d-flex justify-content-end">
              <v-btn
                text
                outlined
                rounded
                small
                @click="reveal = true"
              >
                <v-icon>
                  mdi-refresh
                </v-icon>
                   Review
              </v-btn>
            </v-list-item>
            <v-list-item class="d-flex flex-column justify-content-center">
              <template v-if="book_image === null">
                <img
                  height="160"
                  width="120"
                  src="@/assets/img/20200505_noimage.jpg"
                >
              </template>
              <template v-else>
                <v-img
                  heigth="160"
                  width="120"
                  :src="book_image"
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
                    small
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
    },
    tags: {
        type:Array
    }
  },
  methods: {
    toShowChild() {
      this.$emit(
        'toShowParent', 
        this.user_id,
      )
    },
    searchTagChild(tag) {
      this.$emit(
        'searchTagParent', 
        tag,
      )
    },
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