    <template>
        <div>
          <v-card 
            color="white"
            class="mx-auto"
            width="200"
            @click.stop="dialog = true"
          >
            <template>
              <v-img
                :src="cards[0].src"
                class="white--text align-end"
                gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
                max-height="100%"
                max-width="100%"
              >
                <v-card-title>{{ name }}</v-card-title> 
              </v-img>
              <v-divider></v-divider>
            </template>
          </v-card>

        <v-dialog v-model="dialog" scrollable max-width="600">
          <v-card 
            color="white"
            class="mx-auto"
            width="600"
          >
            <template>
              <b-container class="d-flex justify-content-end">
                <v-btn
                  dark
                  class="white--text"
                  @click="dialog = false"
                >
                close
                </v-btn>
              </b-container>
                <v-img
                  :src="cards[0].src"
                  class="white--text align-end"
                  gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
                  max-height="100%"
                  max-width="100%"
                >
                  <v-card-title>{{ name }}</v-card-title> 
                </v-img>

                <v-card-actions>
                  <v-btn
                    dark
                    class="white--text"
                  >
                    Follow
                  </v-btn>

                  <v-spacer></v-spacer>

                  <v-btn
                    icon
                    @click="show = !show"
                  >
                    <v-icon>{{ show ? 'mdi-chevron-up' : 'mdi-chevron-down' }}</v-icon>
                  </v-btn>
                </v-card-actions>

                <v-expand-transition>
                <div v-show="show">
                  <v-divider></v-divider>
                  <v-card-text>自己紹介：{{profile}}</v-card-text>
                  <v-divider></v-divider>
                  <v-card-text>誕生日：{{age}}</v-card-text>
                  <v-divider></v-divider>
                  <v-card-text>住んでいる場所：{{locate}}</v-card-text>
                  <v-card-actions>
                    <b-container class="d-flex justify-content-end">
                      <v-btn icon>
                        <v-icon>mdi-heart</v-icon>
                      </v-btn>
                    </b-container>
                  </v-card-actions>
                </div>
              </v-expand-transition>
            </template>
          </v-card>
        </v-dialog>
      </div>
    </template>

    <script>
    //いつか使うかも。使わなければ削除。
    export default {
      props: {
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
        }
      },
      data () {
        return {
          cards: [{ title: 'Favorite road trips', src: "https://cdn.pixabay.com/photo/2020/07/12/07/47/bee-5396362_1280.jpg", flex: 6 }],
          dialog: false,
          show: false
        }
      }
    }
    </script>