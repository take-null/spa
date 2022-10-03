<template>
  <v-container>
    <v-row justify="center">
      <b-container class="d-flex justify-content-center">
        <v-btn
          text
          rounded
          outlined
          color="primary"
          @click="loginChild"
          class="mx-auto"
        >
          ゲストログイン
        </v-btn>
      </b-container>
    </v-row>
  </v-container>
</template>

<script>
export default {
  methods: {
    loginChild() {
      this.$emit('loginPatrent')
    },
  },
}
</script>
