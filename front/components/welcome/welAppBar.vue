<template>
  <v-app-bar
    app
    dark
  >
  <appLogo />
    <v-toolbar-title>
      {{ appName }}
    </v-toolbar-title>

        <v-spacer />

    <v-toolbar-items class="ml-2">
      <v-btn
        v-for="(menu, i) in menus"
        :key="`menu-btn-${i}`"
        text
      >
        {{ $t(`menus.${menu.title}`) }}
      </v-btn>
    </v-toolbar-items>
      {{ isScrollPoint }}
  </v-app-bar>
</template>

<script>
import appLogo from '~/components/ui/appLogo.vue'
export default {
  components: { appLogo },
  props: {
    menus: {
        type: Array,
        default: () => []
    },
    imgHeight: {
    type: Number,
    default: 0
    },
  },
  data ({ $config: { appName }, $store }) {
    return {
      appName,
      scrollY: 0,
      appBarHeight: $store.state.styles.beforeLogin.appBarHeight
    }
  },
  computed: {
    isScrollPoint () {
      return this.scrollY > (this.imgHeight - this.appBarHeight)
    }
  },
  mounted () {
    window.addEventListener('scroll', this.onScroll)
  },
  beforeDestroy () {
    window.removeEventListener('scroll', this.onScroll)
  },
  methods: {
    onScroll () {
      this.scrollY = window.scrollY
    }
  }
}
</script>