<template>
<v-app id="inspire">

      <v-container>
        <v-row>
          <v-col>
            <v-sheet
              min-height="70vh"
              rounded="lg"
              width="680"
            >
            <div>
              <myProfile
                :name.sync="user.name"
                :email.sync="user.email" 
                :profile.sync="user.profile" 
                :age.sync="user.age" 
                :locate.sync="user.locate"
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
    user = res))
    return { user }
  },
  // data () 追加
  data () {
    return {
      dialog: false,
      show: false,
      cards: [{ title: 'Favorite road trips', src: "https://cdn.pixabay.com/photo/2020/06/24/19/12/cabbage-5337431_1280.jpg", flex: 6 }],
    }
  },
}
</script>