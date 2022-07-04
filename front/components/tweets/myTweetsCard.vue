<template>
  <div>
  <v-card
    class="mx-auto"
    color="blue-grey"
    dark
    max-width="250"
    @click.stop="dialog = true"
  >
    <v-card-title>
      <v-icon
        large
        left
      >
        mdi-lightbulb-dimmer-40
      </v-icon>
      <span class="text-h6 font-weight-light">{{ name }}</span>
    </v-card-title>

    <v-card-text class="text-h5 font-weight-bold">
      {{content}}
    </v-card-text>

    <v-card-actions>
      <v-list-item class="grow">
        <v-list-item-avatar color="grey darken-3">
          <v-img
            class="elevation-6"
            alt=""
            src="https://avataaars.io/?avatarStyle=Transparent&topType=ShortHairShortCurly&accessoriesType=Prescription02&hairColor=Black&facialHairType=Blank&clotheType=Hoodie&clotheColor=White&eyeType=Default&eyebrowType=DefaultNatural&mouthType=Default&skinColor=Light"
          ></v-img>
        </v-list-item-avatar>

        <v-list-item-content>
          <v-list-item-title><div class="post-date">投稿日：{{ created_at | date }}</div></v-list-item-title>
        </v-list-item-content>

        <v-row
          align="center"
          justify="end"
        >
          <v-icon class="mr-1">
            mdi-heart
          </v-icon>
        </v-row>
      </v-list-item>
    </v-card-actions>
  </v-card>

  <v-dialog v-model="dialog" scrollable max-width="600">
    <v-card
    class="mx-auto"
    color="blue-grey"
    dark
    max-width="600"
    @click.stop="dialog = false"
  >
    <v-card-title>
      <v-icon
        large
        left
      >
        mdi-lightbulb-dimmer-40
      </v-icon>
      <span class="text-h6 font-weight-light">{{ name }}</span>
    </v-card-title>

    <v-card-text class="text-h5 font-weight-bold">
      {{content}}
    </v-card-text>

    <v-card-actions>
      <v-list-item class="grow">
        <v-list-item-avatar color="grey darken-3">
          <v-img
            class="elevation-6"
            alt=""
            src="https://avataaars.io/?avatarStyle=Transparent&topType=ShortHairShortCurly&accessoriesType=Prescription02&hairColor=Black&facialHairType=Blank&clotheType=Hoodie&clotheColor=White&eyeType=Default&eyebrowType=DefaultNatural&mouthType=Default&skinColor=Light"
          ></v-img>
        </v-list-item-avatar>

        <v-list-item-content>
          <v-list-item-title><div class="post-date">投稿日：{{ created_at | date }}</div></v-list-item-title>
        </v-list-item-content>

        <v-row
          align="center"
          justify="end"
        >
          <v-icon class="mr-1">
            mdi-heart
          </v-icon>
        </v-row>
      </v-list-item>
    </v-card-actions>
  </v-card>
  
  
  </v-dialog>
  </div>
</template>

<script>
export default {
  props: {
    name: {
      type: String
    },
    content: {
      type: String
    },
    created_at: {
      type: String
    }
  },
  data () {
    return {
      dialog: false
    }
  },
}
</script>