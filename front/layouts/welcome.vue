<template>
  <v-app>
    <wel-app-bar 
    
      :menus="menus"
      :img-height="imgHeight"  
    />
    <v-sheet> 
    <v-img
      id="scroll-top"
      dark
      src="https://picsum.photos/id/1073/1920/1080?blur=2"
      
      :height="imgHeight"
    >
      <v-row
        align="center"
        justify="center"
        :style="{ height: `${imgHeight}px` }"
      >
        <v-col
          cols="12"
          class="text-center"
        >
          <h1 class="display-1 mb-4">
            コピー
          </h1>
          <h4
            class="subheading"
            :style="{ letterSpacing: '5px' }"
          >
            サブタイトル
          </h4>
        </v-col>
      </v-row>
    </v-img>

    <v-container
      fluid
      :style="{ maxWidth: '1280px' }"
    >
      <v-row
        v-for="(menu, i) in menus"
        :key="`menu-${i}`"
      >
      <v-col
        :id="menu.title"
        cols="12"
      >
        <v-card flat>
          <v-card-title class="justify-center display-1">
            {{ $t(`menus.${menu.title}`) }}
          </v-card-title>
          <v-card-text class="text-center">
            {{ menu.subtitle }}
          </v-card-text>
        </v-card>
      </v-col>

      <v-col cols="12">
        <div :is="`wel-${menu.title}`" />
          </v-col>
        </v-row>
      </v-container>
    </v-sheet>
    <before-login-footer />
  </v-app>
</template>

<script>
import welAppBar from '~/components/welcome/welAppBar'
import welAbout from '~/components/welcome/welAbout'
import welContentOne from '~/components/welcome/welContentOne'
import welContentTwo from '~/components/welcome/welContentTwo'
import welContentThree from '~/components/welcome/welContentThree'

export default {
  components: {
    welAbout, welContentOne, welContentTwo, welContentThree, welAppBar
  },
  data () {
    return {
      imgHeight: 500,
      menus: [
        { title: 'about', subtitle: 'ポートフォリオサイトです' },
        { title: 'content-one', subtitle: 'コンテンツ１です'},
        { title: 'content-two', subtitle: 'コンテンツ２です'},
        { title: 'content-three', subtitle: 'コンテンツ３です'}
      ]
    }
  }
};
</script>