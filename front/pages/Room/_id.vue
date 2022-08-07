<template>
  <v-app>
    <v-main>
      <v-container>
        <v-row class="text-center">
          <v-col cols="12">
            <v-card
              class="mx-auto my-12"
              elevation="2"
              max-width="500"
              color="blue-grey lighten-5"
            >
              {{room}} 
              <v-divider></v-divider>
              <v-card-text
                ><v-row>
                  <v-col cols="12">
                    <v-container
                      ref="scrollTarget"
                      style="height: 450px"
                      class="overflow-y-auto"
                    >
                      <v-row v-for="(msg, i) in messages" :key="i" dense>
                          <div class="balloon_l">
                            <div class="face_icon">
                              <v-avatar>
                                <span class="white--text">
                                  {{ msg }}
                                </span>
                              </v-avatar>
                            </div>
                            <p class="says">
                              {{ msg }}
                            </p>
                          </div>
                      </v-row>
                    </v-container>
                  </v-col>
                </v-row>
              </v-card-text>
              <v-divider></v-divider>
              <v-card-text>
                    <v-text-field
                      autofocus
                      label="メッセージを入力"
                      v-model="message"
                      clearable
                      @keyup.enter="send_onClick"
                    >
                    <template v-slot:append>
                                      <v-col
                cols="12"
                sm="3"
              >
                      <v-btn icon color="grey darken-4" small @click="send_onClick()">
                  <v-icon>mdi-send</v-icon>
                </v-btn></v-col></template>
                    </v-text-field>

              </v-card-text>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </v-app>
</template>
<script>
import { defineComponent } from '@nuxtjs/composition-api'
import ActionCable from 'actioncable'
export default defineComponent({
  components: {
  },
  validate({ params }) {
    return /^\d+$/.test(params.id)
  },
  data () {
    return {
      error: null,
      width: window.innerWidth,
      height: window.innerHeight,
      messages: [],
      message: ""
    }
  },
  async asyncData ({ $axios, params }) {
    let room = []
    let id = null
    id = params.id
    await $axios.$get(`/api/v1/rooms/${params.id}`).then((res) => (
    room = res,
    console.log(room)
    ))
    const roomKeys = Object.keys(room[0] || {})
    console.log(roomKeys)
    return { room, roomKeys, id }
  },
  mounted() {
    this.getMessages()
    window.addEventListener('resize', this.handleResize)
    const cable = ActionCable.createConsumer('ws://localhost:3000/cable')
      this.messageChannel = cable.subscriptions.create({ channel: "RoomChannel", room: `${this.id}`}, {
      connected: () => {
      this.getMessages()
    },
      received: () => {
      this.getMessages()
    }
    })
  },
  beforeUnmount () { 
    this.messageChannel.unsubscribe()
  },
  beforeDestroy: function () {
    window.removeEventListener('resize', this.handleResize)
  },
  methods: {
    async getMessages () {
      try {
        const res = await this.$axios.$get(`api/v1/rooms/messages?id=${this.id}`)
        if (!res) {
          new Error('メッセージ一覧を取得できませんでした')
        }
        this.messages = res
      } catch (err) {
        console.log(err)
      }
    },
    toTop() {
      this.$router.back()
    },
    handleResize: function() {
      this.width = window.innerWidth;
      this.height = window.innerHeight;
    },
    send_onClick () {
      this.messageChannel.perform('receive', {
            user_id: this.$store.state.current.user.id,
            id: this.id,
            message: this.message
        })
        this.message = ''
      }
    }
  },
);
</script>