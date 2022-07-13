    <template>
        <div>
          <v-card 
            color="blue-grey lighten-5"
            class="mx-auto"
            width="680"
            elevation="0"
          >
            <template>
              <v-img
                :src="cards.src"
                class="white--text align-end"
                gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
                max-height="100%"
                max-width="100%"
              >
                <v-card-title><v-icon color="blue" x-large>mdi-account-circle</v-icon>{{ name }}</v-card-title>
                <v-card-text>Following: {{following.length}}    Followers: {{followers.length}}</v-card-text>
              </v-img>
              <v-card-text>自己紹介：{{profile}}</v-card-text>
              <v-divider></v-divider>
              <v-card-text>誕生日：{{age}}</v-card-text>
              <v-divider></v-divider>
              <v-card-text>住んでいる場所：{{locate}}</v-card-text>
            </template>
          </v-card>
      </div>
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
        profile: {
          type: String
        },
        age: {
          type: String
        },
        locate: {
          type: String
        },
        following: {
          type: Array
        },
        followers: {
          type: Array
        }
      },
      data () {
        return {
          //flag: false,
          isValid: false,
          loading: false,
          //error: null,
          cards: { src: "https://picsum.photos/id/1073/1920/1080", flex: 6 },
        }
      },
    };
    </script>