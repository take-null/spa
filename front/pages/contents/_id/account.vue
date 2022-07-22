<template>
  <v-app id="inspire">
    <v-container fluid>
      <v-row>
        <v-col>
          <v-sheet
            color="blue-grey lighten-5"
            rounded="lg"
            max-width="768"
          >
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