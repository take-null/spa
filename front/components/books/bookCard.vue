<template>
  <v-card 
    color="blue-grey lighten-5"
    class="mx-auto"
    max-width="426"
  >
   <v-container>
    <v-row dense>
      <v-col>
          <v-list-item-content>
            <v-list-item class="d-flex flex-column justify-content-start">
              <template v-if="image === null">
                <img
                  height="250"
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
          </v-list-item-content>
      </v-col>
      <v-col>
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
    }
  },
  data () {
    return {
    }
  },
}
</script>