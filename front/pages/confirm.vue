<template>
  <v-container fluid>
    <v-card
      flat
      tile
      color="transparent"
    >
      <v-card-title>
        RailsのUsersテーブルを用いたv-cardの試作品
      </v-card-title>

      <div>
        <v-container fluid>
          <v-row>
            <v-col
              v-for="user in users" :key="user.id">
              <userProfile 
                :name="user.name" 
                :profile="user.profile" 
                :age="user.age" 
                :locate="user.locate"/>
            </v-col>
          </v-row>
        </v-container>
      </div>

      <v-card-title>
        RailsのUsersテーブルを用いたv-simple-tableの試作品
      </v-card-title> 
      <v-card-text>
        <v-simple-table dense>
          <template
            v-if="users.length"
            v-slot:default
          >
            <thead>
              <tr>
                <th
                  v-for="(key, i) in userKeys"
                  :key="`key-${i}`"
                >
                  {{ key }}
                </th>
              </tr>
            </thead>
            <tbody>
              <tr
                v-for="(user, i) in users"
                :key="`user-${i}`"
              >
                <td>{{ user.id }}</td>
                <td>{{ user.name }}</td>
                <td>{{ user.image }}</td>
                <td>{{ user.profile }}</td>
                <td>{{ user.age }}</td>
                <td>{{ user.locate }}</td>
                <td>{{ dateFormat(user.created_at) }}</td>
              </tr>
            </tbody>
          </template>
        </v-simple-table>
      </v-card-text>


      <v-card-title>
        Vuetifyの導入（オリジナルカラーの確認）
      </v-card-title>
      <v-card-text>
        <v-btn
          v-for="(color, i) in colors"
          :key="`color-${i}`"
          :color="color"
          class="mr-2"
        >
          {{ color }}
        </v-btn>
      </v-card-text>



      <v-card-title>
        VuetifyカスタムCSSの検証
      </v-card-title>
      <v-card-text>
        ipad（768px）とmobile（426px）で表示・非表示
      </v-card-text>
      <v-card-text>
        <v-card
          v-for="(cls, i) in customClass"
          :key="`cls-${i}`"
          :color="cls.color"
          :class="cls.name"
        >
          <v-card-text>
            {{ cls.des }}
          </v-card-text>
        </v-card>
      </v-card-text>

    </v-card>
  </v-container>
</template>

<script>
  import userProfile from '~/components/profile/userProfile.vue'
export default {
  components: { userProfile },
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
      colors: ['primary', 'info', 'success', 'warning', 'error', 'background'],
      customClass: [
        { name: 'hidden-ipad-and-down', color: 'error', des: 'ipad未満で隠す' },
        { name: 'hidden-ipad-and-up', color: 'info', des: 'ipad以上で隠す' },
        { name: 'hidden-mobile-and-down', color: 'success', des: 'mobile未満で隠す' },
        { name: 'hidden-mobile-and-up', color: 'warning', des: 'mobile以上で隠す' }
      ]
    }
  },
  computed: {
    dateFormat () {
      return (date) => {
        const dateTimeFormat = new Intl.DateTimeFormat(
          'ja', { dateStyle: 'medium', timeStyle: 'short' }
        )
        return dateTimeFormat.format(new Date(date))
      }
    }
  }
}
</script>