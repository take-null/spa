<template>
  <v-sheet dense nav min-height="70hv" class="sheet">
    <v-carousel hide-delimiters height="max-height">
      <v-carousel-item v-for="(item, i) in items" :key="i">
        <v-container fluid>
          <v-row align="center" justify="center">
            <v-col cols="12" class="text-center">
              <h6>
                {{ item.description }}
              </h6>
            </v-col>
            <v-col cols="12">
              <v-img contain :src="item.src" max-height="max-height" />
            </v-col>
          </v-row>
        </v-container>
      </v-carousel-item>
    </v-carousel>
  </v-sheet>
</template>

<script>
export default {
  data() {
    return {
      items: [
        {
          src: require('@/assets/img/timeline.gif'),
          description: 'タイムライン',
        },
        {
          src: require('@/assets/img/post.gif'),
          description: '本の検索と投稿',
        },
        {
          src: require('@/assets/img/mypage.gif'),
          description: 'ユーザーのマイページ',
        },
        {
          src: require('@/assets/img/chat.gif'),
          description: 'リアルタイムチャット',
        },
      ],
    }
  },
}
</script>
