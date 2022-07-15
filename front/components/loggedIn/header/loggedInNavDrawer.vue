<template>
  <v-navigation-drawer
    v-model="setDrawer"
    app
    clipped
    mobile-breakpoint="960"
  >
   <b-container class="d-flex justify-content-end">
    <v-btn
      text
      outrined
      rounded
      @click="closeDrawerChild"
    >
      close<v-icon>mdi-chevron-left</v-icon>
    </v-btn>
    </b-container>
    <v-list-item-content>
      <v-list-item-subtitle>
        こんにちは、{{ $nxauth.user.name }}さん
      </v-list-item-subtitle>
    </v-list-item-content>

    <v-list>
      <v-list-item
        v-for="(nav, i) in navMenus"
        :key="`nav-${i}`"
        :to="$my.contentsLinkTo($route.params.id, nav.name)"
      >
        <v-list-item-icon>
          <v-icon v-text="nav.icon" />
        </v-list-item-icon>

        <v-list-item-content>
          <v-list-item-title>
            {{ $my.pageTitle(nav.name) }}
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
export default {
  props: {
    drawer: {
      type: Boolean,
      default: null
    }
  },
  data () {
    return {
      navMenus: [
        { name: 'contents-id-account', icon: 'mdi-account-circle' },
        { name: 'contents-id-tweets', icon: 'mdi-view-dashboard'},
        { name: 'contents-id-users', icon: 'mdi-account-group'}
      ]
    }
  },
  methods: {
    closeDrawerChild() {
      this.$emit('closeDrawerParent')
    }
  },
  computed: {
    setDrawer: {
      get () { return this.drawer },
      set (val) { return this.$emit('update:drawer', val) }
    }
  },
}
</script>