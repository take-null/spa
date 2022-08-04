<template>
  <v-avatar
    size="40"
    class="my-app-log"
  >
    <v-img
      :src="require('@/assets/img/instagram_profile_image.png')"
     />
  </v-avatar>
</template>

<script>
export default {
}
</script>

<style lang="scss" scoped>
.my-app-log {
  margin-right: 8px;
  cursor: pointer;
}
</style>