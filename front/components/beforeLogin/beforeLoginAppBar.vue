<template>
    <v-app-bar
      app
      :height="appBarHeight"
      color="brown"
    >
      <nuxt-link
        to="/"
        class="text-decoration-none"
      >
        <appLogo />
      </nuxt-link>

      <appTitle
        class="hidden-mobile-and-down"
      />

      <v-spacer />

      <signupLink />
      <loginLink />
    
    </v-app-bar>
</template>

<script>
import appLogo from '../ui/appLogo.vue'
import appTitle from '../ui/appTitle.vue'
import signupLink from '~/components/beforeLogin/signupLink.vue'
import loginLink from '~/components/beforeLogin/loginLink.vue'

export default {
  components: { appLogo, appTitle, signupLink, loginLink },
  data ({ $store }) {
    return {
      appBarHeight: $store.state.styles.beforeLogin.appBarHeight
    }
  }
};
</script>
