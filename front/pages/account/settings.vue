<template>
<v-app id="inspire">

      <v-container>
        <v-row>
          <v-col>
            <v-sheet
              min-height="70vh"
              rounded="lg"
              max-width="768"
            >
            <div>
              <myProfile
                :name.sync="user.name"
                :image.sync="user.image.url"
                :email.sync="user.email" 
                :profile.sync="user.profile" 
                :age.sync="user.age" 
                :locate.sync="user.locate"
                :following.sync="user.following"
                :followers.sync="user.followers"
              />
            </div>
            </v-sheet>
          </v-col>
        </v-row>
      </v-container>
  </v-app>
</template>

<script>
import myProfile from '~/components/profile/myProfile.vue'
export default {
  components: { myProfile },
  async asyncData ({ $axios, $nxauth }) {
    let user = []
    await $axios.$get(`/api/v1/users/${$nxauth.user.id}`).then((res) => (
    user = res,
    console.log(user)
    ))
    return { user }
  },
  // data () 追加
  data () {
    return {
      dialog: false,
      show: false,
    }
  },
}
</script>