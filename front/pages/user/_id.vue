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
              <div>
      <followAlert v-if="flag1"
        :name.sync="user.name"
      />
    </div>
    <div>                     
      <unfollowAlert v-if="flag2"
        :name.sync="user.name"
      />
    </div>
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
            <v-btn v-if="flag"
              dark
              class="white--text"
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
      </template>
    </v-card>
  </div>
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
  mounted() {
    this.flag = this.user.followers.some(({id}) => id === this.$store.state.current.user.id)
  },
  methods: {
    toTop() {
      this.$router.push('/user')
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