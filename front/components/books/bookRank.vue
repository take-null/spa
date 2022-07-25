<template>
  <v-card 
    color="blue-grey lighten-5"
    class="mx-auto"
    max-width="350"
    height="250"
    elevation="0"
  >
    <v-container
      fluid
    >
      <v-row
        no-gutters
      >
        <v-col
          cols="6"
        >
          <v-list-item-content
            two-line
          >
            <v-list-item>
              <div class="text-sm-subtitle-1 mb-4">
                {{rank}}
              </div>
            </v-list-item>
            <v-list-item>
              <div class="text-sm-body-2 mb-4">
                {{title}}
              </div>
            </v-list-item>
          </v-list-item-content>
        </v-col>
        <v-col
          cols="6"
        >
          <v-list-item-content>
            <v-list-item class="d-flex flex-column justify-content-start">
              <template v-if="image === null">
                <img
                  height="180"
                  width="105"
                  src="@/assets/img/20200505_noimage.jpg"
                >
              </template>
              <template v-else>
                <v-img
                  heigth="180"
                  width="105"
                  :src="image"
                />
              </template>
            </v-list-item>
          </v-list-item-content>
        </v-col>
      </v-row>
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
  data () {
    return {
    }
  },
}
</script>