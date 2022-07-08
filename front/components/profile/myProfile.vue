    <template>
        <div>
          <v-card 
            color="blue-grey lighten-5"
            class="mx-auto"
            width="680"
          >
            <template>
              <v-img
                :src="cards[0].src"
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
              <b-container class="d-flex justify-content-end">
                <v-btn
                  color="light-blue darken-1"
                  class="white--text"
                  @click.stop="dialog = true"
                >
                  編集する
                </v-btn>
              </b-container>
            </template>
          </v-card>

        <v-dialog v-model="dialog" scrollable max-width="400">
          <v-card 
            color="blue-grey lighten-5"
            class="mx-auto"
            width="400"
          >
            <template>
              <b-container class="d-flex justify-content-end">
                <v-btn
                  color="light-blue darken-1"
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
              <v-card-title>
                <v-icon
                  color="light-blue darken-1" 
                  x-large
                >
                  mdi-account-circle
                </v-icon>
                  {{ name }}
                </v-card-title> 
                </v-img>
                <v-card class="my-auto">
                  <v-form
                    ref="form"
                    v-model="isValid"
                  >
                    <v-card-text>
                    <userFormProfile
                      :profile.sync="params.profile" 
                    />
                    </v-card-text>
                    <v-divider></v-divider>
                    <v-card-text>
                    <userFormAge
                      :age.sync="params.age" 
                    />
                    </v-card-text>
                    <v-divider></v-divider>
                    <v-card-text>
                    <userFormLocate
                      :locate.sync="params.locate" 
                    />
                    </v-card-text>
                    <v-card-text class="px-0">
                      <div>{{error}}</div>
                    <v-btn
                      :disabled="!isValid || loading"
                      :loading="loading"
                      block
                      color="light-blue darken-1"
                      class="white--text"
                      @click="change"
                    >
                    変更する
                    </v-btn>
                  </v-card-text>
                </v-form>
              </v-card>
            </template>
          </v-card>
        </v-dialog>
      </div>
    </template>

    <script>
    import userFormProfile from '~/components/user/userFormProfile.vue'
    import userFormLocate from '~/components/user/userFormLocate.vue'
    import userFormAge from '~/components/user/userFormAge.vue'
    export default {
      components: { userFormProfile, userFormLocate, userFormAge },
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
          isValid: false,
          loading: false,
          error: null,
          params: { profile: "", age: "",locate: "" },
          cards: [{ title: 'Favorite road trips', src: "https://cdn.pixabay.com/photo/2020/07/12/07/47/bee-5396362_1280.jpg", flex: 6 }],
          dialog: false,
        }
      },
      methods: {
        async change () {
        try {
          this.loading = true
          const formData = new FormData()
          formData.append('profile', this.params.profile)
          formData.append('age', this.params.age)
          formData.append('locate', this.params.locate)
          await this.$axios.put('/api/v1/auth', formData, {
                'Content-Type': 'multipart/form-data',
          })
          .then(
            (res) => {
            this.$router.go({path: this.$router.currentRoute.path, force: true})
            this.loading = false
            return res
          }
        )
        } catch (error) {
          console.log({error})
          this.loading = false
          this.error = '更新に失敗しました。'
          this.formReset()
        }
        },
        formReset () {
          this.$refs.form.reset()
          this.params = { profile: "", age: "",locate: "" }
        }
      },
    };
    </script>