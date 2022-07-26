<template>
  <v-card 
    color="blue-grey lighten-5"
    class="mx-auto"
    max-width="350"
    elevation="0"
  >
    <v-container>
      <v-list-item-content
        two-line
      >
        <v-list-item>
          <div 
            class="text-sm-subtitle-1 mb-4"
          >
              {{rank}}
          </div>
        </v-list-item>
        <v-list-item>
          <div 
            class="text-sm-body-2 mb-4"
          >
            {{title}}
          </div>
        </v-list-item>
        <v-list-item 
          class="d-flex flex-column justify-content-center"
        >
          <template 
            v-if="image === null"
          >
            <v-card
              max-width="110"
              @click="searchRankChild(google_books_api_id)"
            >
              <v-img :src="require('@/assets/img/20200505_noimage.jpg')" max-height="180" max-width="105">
              </v-img>
            </v-card>
          </template>
          <template 
            v-else
          >
            <v-card
              max-width="110"
              @click="searchRankChild(google_books_api_id)"
            >
            <v-img :src="image" max-height="180" max-width="105">
            </v-img>
            </v-card>
          </template>  
        </v-list-item>
      </v-list-item-content>
    </v-container>
  </v-card>
</template>

<script>

export default {
  props: {
    title: {
      type: String
    },
    image: {
      type: String
    },
    rank: {
      type: String
    },
    google_books_api_id: {
      type: String
    }
  },
    methods: {
    searchRankChild(google_books_api_id) {
      this.$emit(
        'searchRankParent', 
        google_books_api_id,
      )
    },
  },
}
</script>