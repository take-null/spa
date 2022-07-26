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
      <v-tabs
        v-model="tab"
        background-color="transparent"
        color="blue-grey lighten-5"
        grow
      >
        <v-tab
          v-for="item in items"
          :key="item"
        >
          {{item}}  
        </v-tab>
      </v-tabs>
      <v-tabs-items 
        v-model="tab"
      >
        <v-tab-item>       
          <v-container 
            fluid 
            max-width="426"
          >
            <v-row>
              <v-col v-if="!userFollowing.length">
                <p>フォロー中のユーザーはいません</p>
              </v-col>
              <v-col v-else
                v-for="user in userFollowing" :key="user.id"
              >
                <otherCard
                  :id.sync="user.id"
                  :image.sync="user.image.url"
                  :name.sync="user.name" 
                  :profile.sync="user.profile" 
                  :age.sync="user.age" 
                  :locate.sync="user.locate"
                />
              </v-col>
            </v-row>
          </v-container> 
        </v-tab-item>
        <v-tab-item>
          <v-container 
            fluid 
            max-width="426"
          >
            <v-row>
              <v-col v-if="!userFollowers.length">
                <p>フォロワーはいません</p>
              </v-col>
              <v-col v-else
                v-for="user in userFollowers" :key="user.id"
              >
                <otherCard
                  :id.sync="user.id"
                  :image.sync="user.image.url"
                  :name.sync="user.name" 
                  :profile.sync="user.profile" 
                  :age.sync="user.age" 
                  :locate.sync="user.locate"
                />
              </v-col>
            </v-row>
          </v-container>
        </v-tab-item>
      </v-tabs-items>
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
      tab: null,
      dialog: false,
      show: false,
      items: ['Following', 'Followers'],
      fls: [ {title: "following", change: false } ,{title: "followers", change: true} ]
    }
  },
}
</script>