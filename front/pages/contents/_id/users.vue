<template>
  <v-container fluid>
    <v-card
      flat
      tile
      color="transparent"
    >
      <v-card-title>
        Users
      </v-card-title>
        <v-row no-gutters color="transparent" max-width="768" justify="center">
          <v-col
            v-for="(fl, i) in fls"
            :key="`fl-btn-${i}`"
            cols="12"
            sm="4"
          >
            <v-btn
              class="pa-2"
              text
              block
              elevation="0"
              :loading="loading"
              @click="change=fl.change"
            >
              {{ $t(`fls.${fl.title}`) }}
            </v-btn>
          </v-col>
        </v-row>
        <v-container fluid max-width="426">
          <v-row v-if="change === false">
            <v-col v-if="!userFollowing.length">
              <p>フォロー中のユーザーはいません</p>
            </v-col>
            <v-col v-else
              v-for="user in userFollowing" :key="user.id">
              <v-container max-width="426">
                <p>{{user.name}}をフォローしています</p>
              <otherCard
                :id.sync="user.id"
                :image.sync="user.image.url"
                :name.sync="user.name" 
                :profile.sync="user.profile" 
                :age.sync="user.age" 
                :locate.sync="user.locate"
              />
              </v-container>
            </v-col>
          </v-row>
          <v-row v-else>
            <v-col v-if="!userFollowers.length">
              <p>フォロワーはいません</p>
            </v-col>
            <v-col v-else
              v-for="user in userFollowers" :key="user.id">
              <v-container max-width="426">
                <p>{{user.name}}にフォローされています</p>
              <otherCard
                :id.sync="user.id"
                :image.sync="user.image.url"
                :name.sync="user.name" 
                :profile.sync="user.profile" 
                :age.sync="user.age" 
                :locate.sync="user.locate"
              />
              </v-container>
            </v-col>
          </v-row>
        </v-container>
    </v-card>
  </v-container>
</template>
<script>
import otherCard from '~/components/profile/otherCard.vue'
export default {
  components: { otherCard },
  async asyncData ({ $axios, $nxauth}) {
    let user = []
    let userFollowing = []
    let userFollowers = []
    await $axios.$get(`/api/v1/users/${$nxauth.user.id}`)
    .then((res) => (
    user = res,
    userFollowing = res.following,
    userFollowers = res.followers
    ))
    const followingKeys = Object.keys(userFollowing[0] || {}) // 追加,
    const followerKeys = Object.keys(userFollowers[0] || {}) // 追加,
    //console.log(userKeys)
    //return { user, userKeys }
    return { user, userFollowing, userFollowers, followingKeys, followerKeys }
  },
  data () {
    return {
      loading: false,
      change: false,
      dialog: false,
      show: false,
      fls: [ {title: "following", change: false } ,{title: "followers", change: true} ]
    }
  },
}
</script>