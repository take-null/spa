<template>
  <v-navigation-drawer
    v-model="setDrawer"
    app
    clipped
    mobile-breakpoint="420"
    :mini-variant.sync="mini"
  >
    <template v-if="mini === true">
      <b-container class="d-flex justify-content-end">
        <v-btn
          icon
          outrined
          rounded
          @click.stop="closeDrawerChild"
        >
          <v-icon>mdi-chevron-left</v-icon>
        </v-btn>
      </b-container>
    </template>
    <template v-else>
      <b-container class="d-flex justify-content-end">
        <v-btn
          icon
          outrined
          rounded
          @click.stop="mini = !mini"
        >
          <v-icon>mdi-chevron-left</v-icon>
        </v-btn>
      </b-container>
    </template>
    <template v-if="img === null">
      <v-list-item class="px-2">
        <v-list-item-avatar
          size="45"
        >
          <v-btn
            icon
            outlined
            rounded
            @click.stop="mini = !mini"
          >
            <v-icon x-large>
              mdi-account-circle
            </v-icon>
          </v-btn>
        </v-list-item-avatar>
        <v-list-item-title>
          {{$store.state.current.user.name}}
        </v-list-item-title>
      </v-list-item>
    </template>
    <template v-else>
      <v-list-item class="px-2">
        <v-list-item-avatar
          size="45"
        >
          <v-btn
            icon
            outrined
            rounded
            @click.stop="mini = !mini"
          >
            <v-img :src="`http://localhost:3000/${img}`" alt="avatar" />
          </v-btn>
        </v-list-item-avatar>
        <v-list-item-title>
          {{$store.state.current.user.name}}
        </v-list-item-title>
      </v-list-item>
    </template>
    <v-divider></v-divider>
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
    }
  },
  data () {
    return {
      img: this.$store.state.current.user.image.thumb.url,
      navMenus: [
        { name: 'contents-id-main', icon: 'mdi-timer-outline'},
        { name: 'contents-id-account', icon: 'mdi-book-open-page-variant-outline' },
        { name: 'contents-id-users', icon: 'mdi-account-group'},
        { name: 'contents-id-books', icon: 'mdi-magnify'},
      ],
      mini: true
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