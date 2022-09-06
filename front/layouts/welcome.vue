<template>
  <v-app>
    <wel-app-bar 
      :menus="menus"
      :img-height="imgHeight"  
    />
    <v-sheet> 
      <v-img
        id="scroll-top"
        dark
        src="https://picsum.photos/id/24/1920/1080?blur=3"
        gradient="to top right, rgba(100,115,201,.33), rgba(25,32,72,.7)"
        :height="imgHeight"
      >
        <v-row
          align="center"
          justify="center"
          :style="{ height: `${imgHeight}px` }"
        >
          <v-col
            cols="12"
            class="text-center"
          >
            <h1
              class="display-1 mb-4 font-italic"
            >
              {{$config.appName}}
            </h1>
            <h6
              class="subheading"
              :style="{ letterSpacing: '5px' }"
            >
              読む。書く。見つける。繋がる。
            </h6>
          </v-col>
        </v-row>
      </v-img>

      <v-container
        fluid
        :style="{ maxWidth: '960px' }"
      >
        <v-row
          v-for="(menu, i) in menus"
          :key="`menu-${i}`"
        >
          <v-col
            :id="menu.title"
            cols="12"
          >
            <v-card 
              flat
            >
              <v-card-title 
                class="justify-center display-1"
              >
                {{ $t(`menus.${menu.title}`) }}
              </v-card-title>
              <v-card-text 
                class="text-center"
              >
                {{ menu.subtitle }}
              </v-card-text>
            </v-card>
          </v-col>
          <v-col 
            cols="12"
          >
            <div 
              :is="`wel-${menu.title}`" 
              @loginPatrent="login" 
            />
          </v-col>
        </v-row>
      </v-container>
    </v-sheet>
    <before-login-footer />
  </v-app>
</template>

<script>
import welAppBar from '~/components/welcome/welAppBar'
import welAbout from '~/components/welcome/welAbout'
import welContentOne from '~/components/welcome/welContentOne'
export default {
  components: {
    welAbout, welAppBar, welContentOne
  },
  data ({ $config }) {
    return {
      params: { email: `${$config.guestEmail}`, password: `${$config.guestPass}` },
      imgHeight: 500,
      menus: [
        { title: 'about', subtitle: `${$config.appName}は本の情報共有サイトです` },
        { title: 'content-one', subtitle: '本を検索し、書いたレビューをユーザー間で共有できます' },
      ],
    }
  },
  methods: {
    async login () {
      this.loading = true
      await this.$auth.loginWith('local', { data: this.params })
      .then(
      (res) => {
          this.$store.dispatch('login')
          const user = res.data.data
          const expiry = res.headers.expiry 
          this.$nxauth.setData(user)
          this.$nxauth.setStorage(expiry)
          this.notification()
          this.loading = false
          this.$router.go({path: this.$router.currentRoute.path, force: true})
        return res
        }
      )
    },
    async notification() {
      await this.$axios.$get(`/api/v1/users/search?email=${window.localStorage.getItem('uid')}`)
      .then((res) => {
        const user = res
        this.$store.dispatch('getCurrentUser', user)
        .catch(() => this.$nxauth.removeStorage())}
      )
    }
  }
};
</script>