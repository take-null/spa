<template>
  <v-app>
    <v-main>
      <v-card
        flat
        title
        class="mx-auto"
        elevation="0"
        max-width="600"
        color="grey lighten-2"
      >
        <v-card-title>
          ChatRoomList
        </v-card-title>
        <template 
          v-if="!rooms.length"
        >
          <v-card
            elevation="0"
            width="max-width"
            class="mx-auto"
            color="blue-grey lighten-5"
          >
            <p>チャットルームはありません</p>
          </v-card>
        </template>
        <template 
          v-else
        >
          <v-card
            elevation="0"
            width="max-width"
            class="mx-auto"
            color="blue-grey lighten-5"
          >
            <v-virtual-scroll
              :items="rooms"
              height="600"
              item-height="100"
            >
              <template
                v-slot:default="{ item }"
              >
                <v-list
                  three-line
                >
                  <v-list-item 
                    :key="item.id"
                  >
                    <v-list-item-avatar
                      size="40"
                    >
                      <template 
                        v-if="item.other_user.image.url === null"
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
                          :src="`${$config.defaultUrl}${item.other_user.image.thumb.url}`"
                        />
                      </template>
                    </v-list-item-avatar>
                    <v-list-item-content>
                      <v-list-item-title>
                        <strong>
                          {{ item.other_user.name }}
                        </strong>
                      </v-list-item-title>
                      <template 
                        v-if="item.last_message === null"
                      >
                        <v-list-item-subtitle>
                          <p>メッセージの履歴はありません</p>
                        </v-list-item-subtitle>
                      </template>
                      <template
                        v-else
                      >
                        <template
                          v-if="item.last_message.user_id === item.current_user.id"
                        >
                          <v-list-item-subtitle>
                              送信者:{{item.current_user.name}}
                            <div>
                              <small>
                                {{item.last_message.message}}
                              </small>
                            </div>
                          </v-list-item-subtitle>
                        </template>
                        <template
                          v-else
                        >
                          <v-list-item-subtitle>
                            送信者:{{item.other_user.name}}
                            <div>
                              <small>
                                {{item.last_message.message}}
                              </small>
                            </div>
                          </v-list-item-subtitle>
                        </template>
                      </template>
                    </v-list-item-content>
                    <v-list-item-action>
                      <v-btn
                        small
                        text
                        outlined
                        rounded
                        @click="toShowRoom(item.id)"
                      >
                      <v-icon 
                        small
                      >
                        mdi-open-in-new
                      </v-icon>
                        Enter
                      </v-btn>
                    </v-list-item-action>
                  </v-list-item>
                </v-list>
              </template>
            </v-virtual-scroll>
          </v-card>
        </template>
      </v-card>
    </v-main>
  </v-app>
</template>

<script>
export default {
  async asyncData ({$axios}) {
    let rooms = []
    await $axios.$get('/api/v1/rooms/')
    .then((res) => (
      rooms = res
    ))
    return { rooms }
  },
  methods: {
    toShowRoom(id) {
      this.$router.push(`/room/${id}`)
    }
  }
}
</script>