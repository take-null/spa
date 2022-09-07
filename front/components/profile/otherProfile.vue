<template>
  <div>
    <v-card 
      color="blue-grey lighten-5"
      class="mx-auto"
      max-width="768"
      elevation="0"
    >
      <template>
        <div 
          v-if="image === null"
        >
          <v-img
            :src="cards.src"
            class="white--text align-end"
            gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
            max-height="100%"
            max-width="100%"
          >
            <v-card-title>
              {{ name }}
            </v-card-title>
            <v-card-text>
              Following: {{following.length}}/Followers: {{followers.length}}
            </v-card-text>
          </v-img>
        </div>
        <div 
          v-else
        >
          <v-img
            :src="image"
            class="white--text align-end"
            gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
            max-height="100%"
            max-width="100%"
          >
            <v-card-title>
              {{ name }}
            </v-card-title>
            <v-card-text>
              Following: {{following.length}}/Followers: {{followers.length}}
            </v-card-text>
          </v-img>
        </div>
        <v-card-text>
          プロフィール：
        </v-card-text>
        <v-card-text>
          {{profile}}
        </v-card-text>
        <v-divider></v-divider>
        <v-card-text>
          年齢：{{age}}
        </v-card-text>
        <v-card-text>
          生息地：{{locate}}
        </v-card-text>
        <v-card-text>
          レビュー数：{{review}}
        </v-card-text>
        <v-card-text>
          評価したレビュー数：{{good.length}}
        </v-card-text>
      </template>
    </v-card>
  </div>
</template>

<script>
export default {
  props: {
    id: {
      type: Number
    },
    name: {
      type: String
    },
    image: {
      type: String
    },
    profile: {
      type: String
    },
    age: {
      type: String
    },
    locate: {
      type: String
    },
    following: {
      type: Array
    },
    followers: {
      type: Array
    },
    good: {
      type:Array
    },
    review: {
      type:Number
    }
  },
  data () {
    return {
      isValid: false,
      loading: false,
      cards: { src: "https://picsum.photos/id/1073/1920/1080", flex: 6 },
    }
  },
};
</script>