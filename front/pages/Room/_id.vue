<template>
  <v-app>
    <v-main>
      <v-card
        class="mx-auto"
        elevation="0"
        max-width="600"
        color="grey lighten-2"
      >
        <v-card-title
          class="pb-0"
        >
          <p 
            class="text-h6 text--primary"
          >
            ChatRoom
          </p>
        </v-card-title>
        <v-list-item>
          <v-list-item-avatar
            size="40"
          >
            <template 
              v-if="room.current_user.image.url === null"
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
                :src="`${$config.defaultImageUrl}${room.current_user.image.thumb.url}`"
              />
            </template>
          </v-list-item-avatar>
          <v-list-item-content>
            <v-list-item-title>
              <strong>
                {{ room.current_user.name }}
              </strong>
            </v-list-item-title> 
          </v-list-item-content>
        </v-list-item>
        <v-list-item>
          <v-list-item-avatar
            size="40"
          >
            <template 
              v-if="room.other_user.image.url === null"
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
                :src="`${$config.defaultImageUrl}${room.other_user.image.thumb.url}`"
              />
            </template>
          </v-list-item-avatar>
          <v-list-item-content>
            <v-list-item-title>
              <strong>
                {{ room.other_user.name }}
              </strong>
            </v-list-item-title> 
          </v-list-item-content>
        </v-list-item>
        <v-divider></v-divider>
        <v-card-text>
          <v-row>
            <v-col 
              cols="12"
            >
              <v-container
                ref="scrollTarget"
                style="height: 400px"
                class="container overflow-y-auto"
              >
                <v-row 
                  v-for="(msg, i) in formattedMessages" 
                  :key="i" 
                  dense
                >
                  <v-col
                    v-if="msg.user_id === room.current_user.id"
                  >
                    <v-list-item>
                      <v-list-item-content>
                        <v-list-item-title
                          class="text-right text--primary wrap-text"
                        >
                          {{ msg.message }}
                        </v-list-item-title>
                        <v-list-item-subtitle
                          class="text-right"
                        >
                          {{ msg.created_at }}前
                        </v-list-item-subtitle>
                      </v-list-item-content>
                      <v-list-item-avatar
                        size="40"
                      >
                        <template 
                          v-if="room.current_user.image.url === null"
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
                            :src="`${$config.defaultImageUrl}${room.current_user.image.thumb.url}`"
                          />
                        </template>
                      </v-list-item-avatar>
                    </v-list-item>
                  </v-col>
                  <v-col 
                    v-else
                  >
                    <v-list-item>
                      <v-list-item-avatar
                        size="40"
                      >
                        <template 
                          v-if="room.other_user.image.url === null"
                        >
                          <v-icon 
                            color="grey darken-4" 
                            x-large
                          >
                            mdi-account-circle
                          </v-icon>
                        </template>
                        <template v-else>
                          <v-img
                            :src="`${$config.defaultImageUrl}${room.other_user.image.thumb.url}`"
                          />
                        </template>
                      </v-list-item-avatar>
                      <v-list-item-content>
                        <v-list-item-title
                          class="text--primary wrap-text"
                        >
                          {{ msg.message }}
                        </v-list-item-title>
                        <v-list-item-subtitle>
                          {{ msg.created_at }}前
                        </v-list-item-subtitle>
                      </v-list-item-content>
                    </v-list-item>
                  </v-col>
                </v-row>
              </v-container>
            </v-col>
          </v-row>
        </v-card-text>
        <v-divider></v-divider>
        <v-form
          ref="form"
          v-model="isValid"
        >
          <v-card-text>
            <v-textarea
              rows="2"
              autofocus
              :rules="rules"
              :counter="max"
              label="メッセージを入力"
              v-model="message"
              clearable
            >
              <template 
                v-slot:append
              >
                <v-col
                  cols="12"
                >
                  <v-btn
                    :disabled="!isValid || loading"
                    :loading="loading"
                    icon 
                    color="blue" 
                    @click="send_onClick()"
                  >
                    <v-icon>
                      mdi-send
                    </v-icon>
                  </v-btn>
                </v-col>
              </template>
            </v-textarea>
          </v-card-text>
        </v-form>
      </v-card>
    </v-main>
  </v-app>
</template>
<script>
import { formatDistanceToNow } from 'date-fns'
import { ja } from 'date-fns/locale'
import { defineComponent } from '@nuxtjs/composition-api'
import ActionCable from 'actioncable'
export default defineComponent({
  validate({ params }) {
    return /^\d+$/.test(params.id)
  },
  data () {
    const max = 140
    return {
      isValid: false,
      loading: false,
      max,
      rules: [
        v => !!v || '',
        v => (!!v && max >= v.length) || `${max}文字以内で入力してください`
      ],
      error: null,
      messages: [],
      message: "",
      websocketEndpoint: this.$config.websocketEndpoint
    }
  },
  async asyncData ({ $axios, params }) {
    let room = []
    let id = null
    id = params.id
    await $axios.$get(`/api/v1/rooms/${params.id}`)
    .then((res) => (
      room = res
    ))
    return { room, id }
  },
  mounted() {
    this.getMessages()
    const cable = ActionCable.createConsumer(`${this.websocketEndpoint}`)
      this.messageChannel = cable.subscriptions.create({ channel: "RoomChannel", room: `${this.id}`}, {
      connected: () => {
        this.getMessages()
        .then(() => 
          this.scrollToEnd()
        ) 
      },
        received: () => {
        this.getMessages()
        .then(() => 
          this.scrollToEnd()
        )
      }
    })
  },
  beforeDestroy: function () {
    this.messageChannel.unsubscribe()
  },
  computed: {
    formattedMessages () {
      if (!this.messages.length) { return [] }
      return this.messages.map(message => {
        let time = formatDistanceToNow(new Date(message.created_at), { locale: ja })
        return { ...message, created_at: time }
      })
    }
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
      scrollToEnd() {
        this.$nextTick(() => {
          const chatLog = this.$refs.scrollTarget;
          if (!chatLog) return;
          chatLog.scrollTop = chatLog.scrollHeight;
        });
      },
      send_onClick () {
        this.messageChannel.perform('receive', {
            user_id: this.$store.state.current.user.id,
            id: this.id,
            message: this.message
        })
        this.loading = false
        this.message = ""
      }
    }
  },
);
</script>

<style>
.wrap-text {
  word-break: break-all;
  white-space: pre-line;
}

.container::-webkit-scrollbar { 
  display: none;
}

.container {
  scrollbar-width: none;
}
</style>