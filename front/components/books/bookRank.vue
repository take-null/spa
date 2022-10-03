<template>
  <v-card
    color="blue-grey lighten-5"
    class="mx-auto"
    max-width="300"
    elevation="0"
  >
    <v-list-item-content two-line>
      <v-list-item>
        <div class="text-sm-subtitle-1 mb-4">
          {{ rank }}
        </div>
      </v-list-item>
      <v-list-item class="d-flex flex-column justify-content-center">
        <template v-if="image === null">
          <v-card max-width="150" @click="searchRankChild(google_books_api_id)">
            <v-img
              :src="require('@/assets/img/20200505_noimage.jpg')"
              max-height="193"
              max-width="145"
            />
          </v-card>
        </template>
        <template v-else>
          <v-card max-width="150" @click="searchRankChild(google_books_api_id)">
            <v-img :src="image" max-height="193" max-width="145" />
          </v-card>
        </template>
      </v-list-item>
    </v-list-item-content>
  </v-card>
</template>

<script>
export default {
  props: {
    image: {
      type: String,
    },
    rank: {
      type: String,
    },
    google_books_api_id: {
      type: String,
    },
  },
  methods: {
    searchRankChild(google_books_api_id) {
      this.$emit('searchRankParent', google_books_api_id)
    },
  },
}
</script>
