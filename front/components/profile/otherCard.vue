<template>
  <v-card 
    color="blue-grey lighten-5"
    class="mx-auto"
    max-width="426"
    elevation="0"
  >  
    <v-card-title>
      <v-container
        fluid
      >
        <v-row
          dense
        >
          <v-col
            cols="2"
          >
            <v-avatar
              left
            >
              <template v-if="image === null">
                <v-icon color="grey darken-4" x-large>
                  mdi-account-circle
                </v-icon>
              </template>
              <template v-else>
                <v-img
                  :src="img.src"
                  class="white--text align-end"
                  max-height="100%"
                  max-width="100%"
                />
              </template>
            </v-avatar>
          </v-col>
          <v-col
            cols="9"
          >
            <div 
              class="text-sm-h6 mb-4"
            >
              {{name}}
            </div>
          </v-col>
        </v-row>
      </v-container>
    </v-card-title>     
    <v-card-text 
      v-if="profile === null" 
      class="text-h5 font-weight-light"
    >
      こんにちは！
    </v-card-text>
    <v-card-text 
      v-else 
      class="text-sm-h6 mb-4"
    >
      {{profile}}
    </v-card-text>
    <v-card-actions>
      <b-container class="d-flex justify-content-end" >
        <v-btn
          text
          rounded
          outlined
          small
          @click="toShow(id)"
        >
          user detail
        </v-btn>
      </b-container>
    </v-card-actions>
  </v-card>
</template>

<script>
export default {
  props: {
    id: {
      type: Number
    },
    name: {
      type: String
    },
    image: {
      type: String
    },
    profile: {
      type: String
    },
    age: {
      type: String
    },
    locate: {
      type: String
    },
  },
  data () {
    return {
      img: { src: `http://localhost:3000/${this.image}`}
    }
  },
  methods: {
    toShow(id) {
      this.$router.push(`/user/${id}`)
    }
  }
};
</script>