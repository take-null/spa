<template>
  <v-container 
    fluid
  >
    <v-card
      flat
      tile
      color="blue-grey lighten-5"
      max-width="600"
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
                      :src="`http://localhost:3000/${item.other_user.image.url}`"
                    />
                  </template>
                </v-list-item-avatar>
                <v-list-item-content>
                  <v-list-item-title>
                    <strong>
                      {{ item.other_user.name }}
                    </strong>
                  </v-list-item-title> 
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
              <v-divider></v-divider>
            </template>
          </v-virtual-scroll>
        </v-card>
      </template>
    </v-card>
  </v-container>
</template>

<script>
export default {
  async asyncData ({$axios}) {
    let rooms = []
    await $axios.$get('/api/v1/rooms/')
    .then((res) => (
    rooms = res
    ))
    const roomKeys = Object.keys(rooms[0] || {})
    console.log(rooms)
    console.log(roomKeys)
    return { rooms, roomKeys }
  },
  data () {
    return {
    }
  },
  methods: {
    toShowRoom(id) {
      this.$router.push(`/room/${id}`)
    }
  }
}
</script>