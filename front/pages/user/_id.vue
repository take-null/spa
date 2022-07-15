<template>
<v-app id="inspire">

      <v-container>
        <v-row>
          <v-col>
            <v-sheet
              color="blue-grey lighten-5"
              min-height="70vh"
              rounded="lg"
              max-width="768"
            >
            <div>
      <followAlert v-if="flag1"
        :name.sync="user.name"
      />
      <unfollowAlert v-if="flag2"
        :name.sync="user.name"
      />
        <b-container class="d-flex justify-content-end" color="blue-grey lighten-5">
          <v-btn
            text
            rounded
            outlined
            @click="toTop()"
          >
            close
          </v-btn>
        </b-container>
          <otherProfile 
            :id.sync="user.id"
            :name.sync="user.name" 
            :image.sync="user.image.url"
            :profile.sync="user.profile" 
            :age.sync="user.age" 
            :locate.sync="user.locate"
            :following.sync="user.following"
            :followers.sync="user.followers"  
          />
          <b-container class="d-flex justify-content-end">
            <v-btn v-if="flag"
            text
            outlined
              @click="unfollowUser"
            >
              <v-icon>mdi-checkbox-marked-circle</v-icon>
                unFollow
            </v-btn>
            <v-btn v-else
              dark
              class="white--text"
              @click="followUser"
            >
              <v-icon>mdi-checkbox-marked-circle</v-icon>
                Follow
            </v-btn>
          </b-container>
            </div>
            </v-sheet>
          </v-col>
        </v-row>
      </v-container>
  </v-app>
</template>
<script>
import { defineComponent } from '@nuxtjs/composition-api'
import otherProfile from '~/components/profile/otherProfile.vue'
import followAlert from '~/components/followAlert.vue'
import unfollowAlert from '~/components/unfollowAlert.vue'
export default defineComponent({
  components: {
    otherProfile,
    followAlert,
    unfollowAlert
  },
  validate({ params }) {
    return /^\d+$/.test(params.id)
  },
  computed: {
    isPerson () {
      return this.$store.state.current.user
    }
  },
  data () {
    return {
      flag: false,
      flag1: false,
      flag2: false,
      error: null,
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
  mounted() {
    this.flag = this.user.followers.some(({id}) => id === this.$store.state.current.user.id)
  },
  methods: {
    toTop() {
      this.$router.push('/contents/users')
    },  
    async followUser () {
    try {
      await this.$axios.$post('/api/v1/relationships', {
        user_id: this.$store.state.current.user.id, 
        followed_id: this.user.id
      })
      .then(
        (res) => {
        this.flag = true
        this.flag1 = true
        this.flag2 = false
        console.log(res)
        this.user.followers.push(this.$store.state.current.user);
        console.log(this.user)
      }
    )
    //いらないかも
    await this.$axios.$get(`/api/v1/users/${this.user.id}`)
    .then(
      (res) => {
        console.log(res)
      }
    )
    } catch (error) {
      console.log({error})
    }
  },
  async unfollowUser () {
    try {
      await this.$axios.$delete('/api/v1/relationships/delete', {
        params: {
          user_id: this.$store.state.current.user.id, 
          followed_id: this.user.id,
        },
      })
      .then(
        (res) => {
        this.flag = false
        this.flag2 = true
        this.flag1 = false
        console.log(res)
        this.user.followers.pop(this.$store.state.current.user);
        console.log(this.user)
      }
    )
    //いらないかも
    await this.$axios.$get(`/api/v1/users/${this.user.id}`)
    .then(
      (res) => {
          console.log(res)
        }
      )
         } catch (error) {
           console.log({error})
         }
       },
    },
  },
);
</script>