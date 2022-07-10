<template>
  <v-container fluid>
    <v-card
      flat
      tile
      color="transparent"
    >

      <div>
        <v-container fluid>
          <myProfile
            :name.sync="user.name"
            :email.sync="user.email" 
            :profile.sync="user.profile" 
            :age.sync="user.age" 
            :locate.sync="user.locate"
          />
        </v-container>
      </div>
    </v-card>
  </v-container>
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