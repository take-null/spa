    <template>
        <div>
          <v-card 
            color="blue-grey lighten-5"
            class="mx-auto"
            max-width="768"
            elevation="0"
          >
            <template>
              <b-container class="d-flex justify-content-end">
                <v-btn
                  text
                  outlined
                  rounded
                  @click.stop="dialog = true"
                >
                  edit user
                </v-btn>
              </b-container>
              <div v-if="image === null">
              <v-img
                :src="cards.src"
                class="white--text align-end"
                gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
                max-height="100%"
                max-width="100%"
              >
                <v-card-title>
                  {{ name }}
                </v-card-title>
                <v-card-text>Following: {{following.length}}/Followers: {{followers.length}}</v-card-text>
              </v-img>
              </div>
              <div v-else>
              <v-img
                :src="`http://localhost:3000/${image}`"
                class="white--text align-end"
                gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
                max-height="100%"
                max-width="100%"
              >
                <v-card-title>
                  {{ name }}
                </v-card-title>
                <v-card-text>Following: {{following.length}}/Followers: {{followers.length}}</v-card-text>
              </v-img>
              </div>
              <v-card-text>プロフィール:</v-card-text>
              <v-card-text>{{profile}}</v-card-text>
              <v-divider></v-divider>
              <v-card-text>年齢：{{age}}</v-card-text>
              <v-divider></v-divider>
              <v-card-text>生息地：{{locate}}</v-card-text>
              <v-divider></v-divider>
              <v-card-text>レビュー数：{{review}}</v-card-text>
              <v-divider></v-divider>
              <v-card-text>評価されたレビュー数：{{good.length}}</v-card-text>
            </template>
            
          </v-card>

        <v-dialog v-model="dialog" max-width="max-width">
          <v-card 
            color="blue-grey lighten-5"
            class="mx-auto"
          >
            <template>
              <b-container class="d-flex justify-content-end">
                <v-btn
                  text
                  outlined
                  rounded
                  @click="dialog = false"
                >
                close
                </v-btn>
              </b-container>
                
                <v-card class="my-auto">
                  <v-card-text><userFormImage /></v-card-text>
                  <v-form
                    ref="form"
                    v-model="isValid"
                  >
                  <v-card-text>
                  <v-icon> mdi-badge-account-horizontal </v-icon>
                  <span>プロフィール</span>
                  </v-card-text>
                    <v-card-text>
                    <userFormProfile
                      :profile.sync="params.profile" 
                    />
                    </v-card-text>
                    <v-card-text>
                    <userFormAge
                      :age.sync="params.age" 
                    />
                    </v-card-text>
                    <v-card-text>
                    <userFormLocate
                      :locate.sync="params.locate" 
                    />
                    </v-card-text>
                    <v-card-text class="px-0">
                      <div>{{error}}</div>
                    <v-btn
                      :loading="loading"
                      block
                      dark
                      class="white--text"
                      @click.stop="change"
                    >
                    プロフィールを更新
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
    import userFormImage from '~/components/user/userFormImage.vue'
    import userFormProfile from '~/components/user/userFormProfile.vue'
    import userFormLocate from '~/components/user/userFormLocate.vue'
    import userFormAge from '~/components/user/userFormAge.vue'
    export default {
      components: { userFormProfile, userFormLocate, userFormAge, userFormImage },
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
        },
        image: {
          type: String
        },
        good: {
          type:Array
        },
        review: {
          type:Number
        }
      },
      data () {
        return {
          isValid: false,
          loading: false,
          error: null,
          params: { profile: "", age: "",locate: "" },
          cards: { src: "https://picsum.photos/id/1073/1920/1080", flex: 6 },
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