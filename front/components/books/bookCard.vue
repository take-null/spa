<template>
  <v-card 
    color="blue-grey lighten-5"
    class="mx-auto"
    max-width="426"
    height="280"
  >
   <v-container>
    <v-row dense>
      <v-col cols="6">
          <v-list-item-content>
            <v-list-item class="d-flex flex-column justify-content-start">
              <template v-if="image === null">
                <v-img
                  max-height="250"
                  max-width="150"
                  :src="require('@/assets/img/20200505_noimage.jpg')"
                />
              </template>
              <template v-else>
                <v-img
                  max-heigth="250"
                  max-width="150"
                  :src="image"
                />
              </template>
            </v-list-item>
          </v-list-item-content>
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
        <div class="d-flex justify-content-end">
          <v-btn
            @click="openDialogChild"
            dark
            class="white--text"
          >
            <v-icon>mdi-pencil-plus</v-icon>
          </v-btn>
        </div>
      </v-col>
    </v-row>
    </v-container>
  </v-card>
</template>

<script>

export default {
  props: {
    publisher: {
      type: String
    },
    title: {
      type: String
    },
    authors: {
      type: String
    },
    published_at: {
      type: String
    },
    image: {
      type: String
    },
    google_books_api_id: {
      type: String
    }
  },
  methods: {
    openDialogChild() {
      this.$emit(
        'openDialogParent', 
        this.google_books_api_id,
        this.publisher,
        this.title,
        this.authors,
        this.published_at,
        this.image
      )
    }
  },
  data () {
    return {
    }
  },
}
</script>