<template>
  <v-sheet>
  <v-app-bar
    app
    dense
    elevation="1"
    clipped-left
    dark
  >
    <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>

    <nuxt-link
      to="/"
      class="text-decoration-none"
    >
      <appLogo />
    </nuxt-link>

    <appTitle
      class="hidden-mobile-and-down"
    />

    <v-spacer />

    <v-menu
      app
      offset-x
      offset-y
      max-width="1000"
    >
      <template v-if="img === null"  v-slot:activator="{ on }">
        <v-btn
          icon
          v-on="on"
        >
          <v-avatar size="40">
            <v-icon x-large>
              mdi-account-circle
            </v-icon>
          </v-avatar>
        </v-btn>
      </template>
      <template v-else  v-slot:activator="{ on }">
        <v-btn
          icon
          v-on="on"
        >
          <v-avatar size="40" class="user-image">
            <v-img :src="`http://localhost:3000/${img}`" alt="avatar" />
          </v-avatar>
        </v-btn>
      </template>
      <v-list dense>
        <v-subheader>
          ログイン中のユーザー
        </v-subheader>

        <v-list-item>
          <v-list-item-content>
            <v-list-item-subtitle>
              <!-- ログイン中のユーザー名 -->
              {{ $nxauth.user.name }}
            </v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>

        <v-divider />

        <v-subheader>
          アカウント
        </v-subheader>

        <template v-for="(menu, i) in accountMenus">
          <v-divider
            v-if="menu.divider"
            :key="`menu-divider-${i}`"
          />

          <v-list-item
            :key="`menu-list-${i}`"
            :to="{ name: menu.name }"
          >
            <v-list-item-icon class="mr-2">
              <v-icon size="22" v-text="menu.icon" />
            </v-list-item-icon>
            <v-list-item-title>
              {{ $my.pageTitle(menu.name) }}
            </v-list-item-title>
          </v-list-item>
        </template>
      </v-list>
    </v-menu>
  </v-app-bar>
    <logged-in-nav-drawer
      v-if="drawer"
      :drawer.sync="drawer"
      @closeDrawerParent="close"
    />

  </v-sheet>
</template>
<script>
import appLogo from '~/components/ui/appLogo.vue'
import appTitle from '~/components/ui/appTitle.vue'
import myIdea from '~/components/tweets/tweetPost.vue'
export default {
  components: { appLogo, appTitle, myIdea },
  data () {
    return {
      img: this.$store.state.current.user.image.thumb.url,
      drawer: null,
      accountMenus: [
        { name: 'account-settings', icon: 'mdi-account-cog' },
        { name: 'account-password', icon: 'mdi-lock-outline' },
        { name: 'logout', icon: 'mdi-logout-variant', divider: true }
      ],
    }
  },
  methods: {
    close() {
      this.drawer = false;
    }
  }
};
</script>