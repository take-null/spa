<template>
  <v-app>
    <v-main>
      <v-card
        flat
        tile
        class="mx-auto"
        elevation="0"
        max-width="600"
        color="grey lighten-2"
      >
        <v-card-title>
          Users
        </v-card-title>
        <v-tabs
          v-model="tab"
          grow
        >
          <v-tab
            v-for="friend in friends"
            :key="friend"
          >
            {{friend}}  
          </v-tab>
        </v-tabs>
          <v-tabs-items 
            v-model="tab"
          >
            <v-tab-item>
              <template 
                v-if="!userFollowing.length"
              >
                <v-card
                  elevation="0"
                  width="max-width"
                  class="mx-auto"
                  color="blue-grey lighten-5"
                >
                  <p>フォロー中のユーザーはいません</p>
                </v-card>
              </template>
              <template 
                v-else
              >
                <div>
                  <v-card
                    elevation="0"
                    width="max-width"
                    class="mx-auto"
                    color="blue-grey lighten-5"
                  >
                    <v-virtual-scroll
                      :items="userFollowing"
                      height="300"
                      item-height="80"
                    >
                      <template 
                        v-slot:default="{ item }"
                      >
                        <v-list-item 
                          :key="item.id"
                        >
                          <v-list-item-avatar
                            size="40"
                          >
                            <template 
                              v-if="item.image.url === null"
                            >
                              <v-icon 
                                color="grey darken-4" 
                                x-large
                              >
                                mdi-account-circle
                              </v-icon>
                            </template>
                            <template 
                              v-else
                            >
                              <v-img
                                :src="`${$config.defaultUrl}${item.image.url}`"
                              />
                            </template>
                          </v-list-item-avatar>
                          <v-list-item-content
                            two-line
                          >
                            <v-list-item-title>
                              <strong>
                                {{ item.name }}
                              </strong>
                            </v-list-item-title>
                            <v-list-item-subtitle>
                              <template 
                                v-if="item.profile === null" 
                              >
                                こんにちは！
                              </template>
                              <template
                                v-else 
                                class="text-sm-h6 mb-4"
                              >
                                {{item.profile}}
                              </template>
                            </v-list-item-subtitle>
                          </v-list-item-content>
                          <v-list-item-action>
                            <v-btn
                              small
                              text
                              outlined
                              rounded
                              @click="toShow(item.id)"
                            >
                              <v-icon 
                                small
                              >
                                mdi-open-in-new
                              </v-icon>
                                detail
                            </v-btn>
                          </v-list-item-action>
                        </v-list-item>
                      <v-divider></v-divider>
                    </template>
                  </v-virtual-scroll>
                </v-card>
              </div>
            </template>       
          </v-tab-item>

          <v-tab-item>
            <template 
              v-if="!userFollowers.length"
            >
              <v-card
                elevation="0"
                width="max-width"
                class="mx-auto"
                color="blue-grey lighten-5"
              >
                <p>フォロワーはいません</p>
              </v-card>
            </template>
            <template v-else>
              <div>
                <v-card
                  elevation="0"
                  width="max-width"
                  class="mx-auto"
                  color="blue-grey lighten-5"
                >
                  <v-virtual-scroll
                    :items="userFollowers"
                    height="300"
                    item-height="80"
                  >
                    <template 
                      v-slot:default="{ item }"
                    >
                      <v-list-item 
                        :key="item.id"
                      >
                        <v-list-item-avatar
                          size="40"
                        >
                          <template 
                            v-if="item.image.url === null"
                          >
                            <v-icon 
                              color="grey darken-4" 
                              x-large
                            >
                              mdi-account-circle
                            </v-icon>
                          </template>
                          <template 
                            v-else
                          >
                            <v-img
                              :src="`${$config.defaultUrl}${item.image.url}`"
                            />
                          </template>
                        </v-list-item-avatar>
                        <v-list-item-content
                          two-line
                        >
                          <v-list-item-title>
                            <strong>
                              {{ item.name }}
                            </strong>
                          </v-list-item-title>
                          <v-list-item-subtitle>
                            <template 
                              v-if="item.profile === null" 
                            >
                              こんにちは！
                            </template>
                            <template
                              v-else 
                              class="text-sm-h6 mb-4"
                            >
                              {{item.profile}}
                            </template>
                          </v-list-item-subtitle>
                        </v-list-item-content>
                        <v-list-item-action>
                          <v-btn
                            small
                            text
                            outlined
                            rounded
                            @click="toShow(item.id)"
                          >
                            <v-icon 
                              small
                            >
                              mdi-open-in-new
                            </v-icon>
                              detail
                            </v-btn>
                          </v-list-item-action>
                        </v-list-item>
                      <v-divider></v-divider>
                    </template>
                  </v-virtual-scroll>
                </v-card>
              </div>
            </template>       
          </v-tab-item>
        </v-tabs-items>
      </v-card>
    </v-main>
  </v-app>
</template>

<script>
export default {
  components: {},
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
    return { user, userFollowing, userFollowers }
  },
  data () {
    return {
      loading: false,
      change: false,
      tab: null,
      dialog: false,
      show: false,
      friends: ['Following', 'Followers'],
      fls: [ {title: "following", change: false } ,{title: "followers", change: true} ]
    }
  },
  methods: {
    toShow(id) {
      this.$router.push(`/user/${id}`)
    }
  }
}
</script>