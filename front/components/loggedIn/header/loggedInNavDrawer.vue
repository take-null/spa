<template>
  <v-navigation-drawer
    v-model="setDrawer"
    app
    clipped
    mobile-breakpoint="960"
  >
   <b-container class="d-flex justify-content-end">
    <v-btn
      dark
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
      <v-divider />

      <v-list-item
        href="https://blog.cloud-acct.com/categories/udemy"
        target="_blank"
      >
        <v-list-item-icon>
          <v-icon>
            mdi-open-in-new
          </v-icon>
        </v-list-item-icon>

        <v-list-item-content>
          <v-list-item-title>
            このアプリの作り方
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