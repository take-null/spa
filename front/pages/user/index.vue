<template>
  <v-container fluid class="grey lighten-5">
    <v-card
      flat
      tile
      color="transparent"
    >
      <v-card-title>
        Users
      </v-card-title>
      <div>
        <v-container class="grey lighten-5">
          <v-row no-gutters>
            <v-col
              v-for="n in 2"
              :key="n"
              cols="12"
              sm="4"
            >
              <v-btn
                class="pa-2"
                outlined
                tile
              >
                One of three columns
              </v-btn>
            </v-col>
          </v-row>
        </v-container>
      </div>
      <div>
        <v-container fluid>
          <v-row>
            <v-col
              v-for="user in users" :key="user.id">
            <v-card>
              <otherProfile 
                :id.sync="user.id"
                :image.sync="user.image"
                :name.sync="user.name" 
                :profile.sync="user.profile" 
                :age.sync="user.age" 
                :locate.sync="user.locate"
                :following.sync="user.following"
                :followers.sync="user.followers"
              />
                <b-container class="d-flex justify-content-end" >
                <v-btn
                  class="white--text"
                  dark
                  @click="toShow(user.id)"
                >
                  user detail
                </v-btn>
              </b-container>
            </v-card>
            </v-col>
          </v-row>
        </v-container>
      </div>
    </v-card>
    <div>
      {{users}}
    </div>
  </v-container>
</template>
<script>
  import otherProfile from '~/components/profile/otherProfile.vue'
export default {
  components: { otherProfile },
  async asyncData ({ $axios }) {
    let users = []
    await $axios.$get('/api/v1/users').then(res => (users = res, console.log(users)))
    //Object.keys() メソッドは、
    //指定されたオブジェクトが持つプロパティの 名前の配列を、
    //通常のループで取得するのと同じ順序で返します。
    //const arr = ['a', 'b', 'c'];
    //console.log(Object.keys(arr)); // console: ['0', '1', '2']
    const userKeys = Object.keys(users[0] || {}) // 追加
    console.log(userKeys)
    return { users, userKeys }
  },
  // data () 追加
  data () {
    return {
      dialog: false,
      show: false,
      cards: [{ title: 'Favorite road trips', src: "https://cdn.pixabay.com/photo/2020/06/24/19/12/cabbage-5337431_1280.jpg", flex: 6 }],
    }
  },
  methods: {
    toShow(id) {
    this.$router.push(`/user/${id}`)
    }
  }
}
</script>