    <template>
      <div>
        <v-card-title>
         {{user.name}}
        </v-card-title>
        <v-card 
            color="blue-grey lighten-5"
            class="mx-auto"
            width="680"
          >
            <template>
              <b-container class="d-flex justify-content-end">
                <v-btn
                  @click="toTop()"
                  elevation="0"
                >
                  ✕
                </v-btn>
              </b-container>
              <otherProfile 
                :id.sync="user.id"
                :name.sync="user.name" 
                :profile.sync="user.profile" 
                :age.sync="user.age" 
                :locate.sync="user.locate"
                :following.sync="user.following"
                :followers.sync="user.followers"  
              />
              <b-container class="d-flex justify-content-end">
                <v-btn
                  color="light-blue darken-1"
                  class="white--text"
                  @click="unfollow"
                >
                <v-icon>mdi-checkbox-marked-circle</v-icon>
                  Follow
                </v-btn>
              </b-container>
            </template>
          </v-card>
      </div>
    </template>

<script>
import { defineComponent } from '@nuxtjs/composition-api'
import otherProfile from '~/components/profile/otherProfile.vue'
export default defineComponent({
  components: {
    otherProfile
  },
  validate({ params }) {
    return /^\d+$/.test(params.id)
  },
  data () {
    return {
      //flag: false,
      isValid: false,
      loading: false,
      //error: null,
      cards: [{ title: 'Favorite road trips', src: "https://cdn.pixabay.com/photo/2020/07/12/07/47/bee-5396362_1280.jpg", flex: 6 }],
    }
  },
    async asyncData ({ $axios, params }) {
    let user = []
    await $axios.$get(`/api/v1/users/${params.id}`).then((res) => (
    user = res,
    console.log(user)
    ))
    return { user }
  },
  methods: {
    toTop() {
    this.$router.push('/user')
  },
    async follow () {
    try {
      this.loading = true
      await this.$axios.$post('/api/v1/relationships', {
        user_id: this.$store.state.current.user.id, 
        followed_id: this.user.id
      })
      .then(
        (res) => {
        this.loading = false
        return res
      }
    )
    await this.$axios.$get(`/api/v1/users/${this.user.id}`)
    .then(
      (res) => {
        console.log(res)
      }
    )
    } catch (error) {
      console.log({error})
      this.loading = false
      this.error = '失敗しました。'
    }
    },
    async unfollow () {
    try {
      this.loading = true
      await this.$axios.$delete('/api/v1/relationships/delete', {
          params: {
            user_id: this.$store.state.current.user.id, 
            followed_id: this.user.id,
          },
        })
      .then(
        (res) => {
        this.loading = false
        return res
      }
    )
    await this.$axios.$get(`/api/v1/users/${this.user.id}`)
    .then(
      (res) => {
        console.log(res)
      }
    )
    } catch (error) {
      console.log({error})
      this.loading = false
      this.error = '失敗しました。'
    }
    },
  },
});
</script>