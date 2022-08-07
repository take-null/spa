<template>
  <v-container 
    fluid
  >
    <v-card
      flat
      tile
      color="blue-grey lighten-5"
      max-width="768"
      minheigth="70hv"
    >
      <v-card-title>
        ChatRoom
      </v-card-title>
    </v-card>
  </v-container>
</template>

<script>
export default {
  components: {},
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
    toShowRoom() {
      this.$router.push(`/`)
    }
  }
}
</script>