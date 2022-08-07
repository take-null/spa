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

    <v-btn 
      icon
      @click.prevent="moveChatPage()"
    >
      <v-icon>
        mdi-email-outline
      </v-icon>
    </v-btn>

    <v-btn 
      icon
      @click.prevent="moveSearchPage()"
    >
      <v-icon>
        mdi-magnify
      </v-icon>
    </v-btn>
    
    <template 
      v-if="notification.length === 0"
    >
      <v-icon>
        mdi-bell-outline
      </v-icon>
    </template>
    <template
      v-else
    >
      <v-menu
        app
        offset-x
        offset-y
        max-width="1000"
      >
      <template v-slot:activator="{ on }">
        <v-btn
          icon
          v-on="on"
        >
          <v-icon
            color="red"
          >
            mdi-bell
          </v-icon>
          <p
            class="white--text text-caption"
          >
            {{notification.length}}
          </p>
        </v-btn>
      </template>
        <v-list
          color="blue-grey lighten-5"
        >
          <v-list-item v-model="notification"  v-for="notice in notification" :key="notice.id">
            <v-list-item-title v-if="notice.action === 'follow'">
              <v-card
                class="mx-auto"
                max-width="425"
                color="blue-grey lighten-5"
              >
                <v-card-actions>
                  <v-container v-if="notice.user_image === ''">
                    <v-row>
                      <v-col
                        cols="2"
                      >
                        <v-btn
                          icon
                          @click="showUser(notice.visitor_id)"
                        >
                          <v-avatar size="40">
                            <v-icon x-large>
                              mdi-account-circle
                            </v-icon>
                          </v-avatar>
                        </v-btn>
                      </v-col>
                      <v-col
                        cols="9">
                        {{notice.user_name}}があなたをフォローしました
                      </v-col>
                      <v-col
                        cols="1"
                      >
                        <v-btn
                          icon
                          x-small
                          @click="deleteNotice(notice.id)"
                        >
                          <v-icon
                            color="green"
                          >
                            mdi-check
                          </v-icon>
                        </v-btn>
                      </v-col>
                    </v-row>
                  </v-container>
                  <v-container v-else>
                    <v-row>
                      <v-col
                        cols="2"
                      >
                        <v-btn
                          icon
                          @click="showUser(notice.visitor_id)"
                        >
                          <v-avatar size="40" class="user-image">
                            <v-img :src="`http://localhost:3000/${notice.user_image}`" alt="avatar" />
                          </v-avatar>
                        </v-btn>
                      </v-col>
                      <v-col
                        cols="9">
                        {{notice.user_name}}があなたをフォローしました
                      </v-col>
                      <v-col
                        cols="1"
                      >
                        <v-btn
                          icon
                          x-small
                          @click="deleteNotice(notice.id)"
                        >
                          <v-icon
                            color="green"
                          >
                            mdi-check
                          </v-icon>
                        </v-btn>
                      </v-col>
                    </v-row>
                  </v-container>
                </v-card-actions>
              </v-card>
            </v-list-item-title>
            <v-list-item-title v-else-if="notice.action === 'chat_message'">
              <v-card
                class="mx-auto"
                max-width="425"
                color="blue-grey lighten-5"
              >
                <v-card-actions>
                  <v-container v-if="notice.user_image === ''">
                    <v-row>
                      <v-col
                        cols="2"
                      >
                        <v-btn
                          icon
                          @click="showUser(notice.visitor_id)"
                        >
                          <v-avatar size="40">
                            <v-icon x-large>
                              mdi-account-circle
                            </v-icon>
                          </v-avatar>
                        </v-btn>
                      </v-col>
                      <v-col
                        cols="9"
                      >
                        {{notice.user_name}}があなたにメッセージを送りました
                      </v-col>
                      <v-col
                        cols="1"
                      >
                        <v-btn
                          icon
                          x-small
                          @click="deleteNotice(notice.id)"
                        >
                          <v-icon
                            color="green"
                          >
                            mdi-check
                          </v-icon>
                        </v-btn>
                      </v-col>
                    </v-row>
                  </v-container>
                  <v-container v-else>
                    <v-row>
                      <v-col
                        cols="2"
                      >
                        <v-btn
                          icon
                          @click="showUser(notice.visitor_id)"
                        >
                          <v-avatar size="40" class="user-image">
                            <v-img :src="`http://localhost:3000/${notice.user_image}`" alt="avatar" />
                          </v-avatar>
                        </v-btn>
                      </v-col>
                      <v-col
                        cols="9"
                      >
                        {{notice.user_name}}があなたにメッセージを送りました
                      </v-col>
                      <v-col
                        cols="1"
                      >
                        <v-btn
                          icon
                          x-small
                          @click="deleteNotice(notice.id)"
                        >
                          <v-icon
                            color="green"
                          >
                            mdi-check
                          </v-icon>
                        </v-btn>
                      </v-col>
                    </v-row>
                  </v-container>
                </v-card-actions>
              </v-card>
            </v-list-item-title>
            <v-list-item-title v-else>
              <v-card
                class="mx-auto"
                max-width="425"
                color="blue-grey lighten-5"
              >
                <v-card-actions>
                  <v-container v-if="notice.user_image === ''">
                    <v-row>
                      <v-col
                        cols="2"
                      >
                        <v-btn
                          icon
                          @click="showUser(notice.visitor_id)"
                        >
                          <v-avatar size="40">
                            <v-icon x-large>
                              mdi-account-circle
                            </v-icon>
                          </v-avatar>
                        </v-btn>
                      </v-col>
                      <v-col
                        cols="9"
                      >
                        {{notice.user_name}}があなたの投稿を評価しました
                      </v-col>
                      <v-col
                        cols="1"
                      >
                        <v-btn
                          icon
                          x-small
                          @click="deleteNotice(notice.id)"
                        >
                          <v-icon
                            color="green"
                          >
                            mdi-check
                          </v-icon>
                        </v-btn>
                      </v-col>
                    </v-row>
                  </v-container>
                  <v-container v-else>
                    <v-row>
                      <v-col
                        cols="2"
                      >
                        <v-btn
                          icon
                          @click="showUser(notice.visitor_id)"
                        >
                          <v-avatar size="40" class="user-image">
                            <v-img :src="`http://localhost:3000/${notice.user_image}`" alt="avatar" />
                          </v-avatar>
                        </v-btn>
                      </v-col>
                      <v-col
                        cols="9"
                      >
                        {{notice.user_name}}があなたの投稿を評価しました
                      </v-col>
                      <v-col
                        cols="1"
                      >
                        <v-btn
                          icon
                          x-small
                          @click="deleteNotice(notice.id)"
                        >
                          <v-icon
                            color="green"
                          >
                            mdi-check
                          </v-icon>
                        </v-btn>
                      </v-col>
                    </v-row>
                  </v-container>
                </v-card-actions>
              </v-card>
            </v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
    </template>
   
    <v-menu
      app
      offset-x
      offset-y
      max-width="1000"
    >
      <template v-slot:activator="{ on }">
        <v-btn
          icon
          v-on="on"
        >
          <v-avatar size="50">
            <v-icon>
              mdi-account-cog
            </v-icon>
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
        
        <v-list v-for="(menu, i) in accountMenus" :key=i>
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
        </v-list>
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
export default {
  components: { appLogo, appTitle },
  data () {
    return {
      notification: this.$store.state.current.user.passive_notifications,
      drawer: false,
      accountMenus: [
        { name: 'account-settings', icon: 'mdi-book-open-page-variant-outline' },
        { name: 'account-password', icon: 'mdi-lock-outline' },
        { name: 'logout', icon: 'mdi-logout-variant', divider: true }
      ],
      keyword: ""
    }
  },
  methods: {
    close() {
      this.drawer = false
    },
    showUser(id) {
      if (`/user/${id}` !== this.$route.fullPath) {
        this.$router.replace(`/user/${id}`)
      }
    },
    async deleteNotice(id) {
      await this.$axios.$delete(`/api/v1/notifications/${id}`)
      .then((res) => {
        console.log(res)
        this.$store.commit('deleteNotice', id)
      })
    },
    moveSearchPage() {
      this.$router.replace('/contents/1/books')
    },
    moveChatPage() {
      this.$router.replace('/contents/1/chat')
    }
  },
};
</script>