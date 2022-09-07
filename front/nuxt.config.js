import colors from 'vuetify/es5/util/colors'

export default {
  // Disable server-side rendering: https://go.nuxtjs.dev/ssr-mode
  ssr: false,

  // Global page headers: https://go.nuxtjs.dev/config-head
  head: {
    titleTemplate: `${process.env.APP_NAME}`,
    title: `${process.env.APP_NAME}`,
    htmlAttrs: {
      lang: 'en',
    },
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: '' },
      { name: 'format-detection', content: 'telephone=no' },
    ],
    link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }],
  },

  // Global CSS: https://go.nuxtjs.dev/config-css
  css: [
    '~/assets/sass/main.scss'
  ],

  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: [
    'plugins/nxauth',
    'plugins/myInject',
    '~/plugins/axios.js',
    'plugins/nxClientInit',
    '~plugins/date-filter.js',
    { src: "~/plugins/vue-infinite-loading", ssr: false },
  ],

  // Auto import components: https://go.nuxtjs.dev/config-components
  components: true,

  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [
    // https://go.nuxtjs.dev/eslint
    '@nuxtjs/eslint-module',
    // https://go.nuxtjs.dev/vuetify
    '@nuxtjs/vuetify',
    '@nuxtjs/composition-api/module',
  ],

  // Modules: https://go.nuxtjs.dev/config-modules
  modules: [
    // https://go.nuxtjs.dev/axios
    '@nuxtjs/axios',
    '@nuxtjs/auth',
    'nuxt-i18n',
    'bootstrap-vue/nuxt',
  ],

  // Axios module configuration: https://go.nuxtjs.dev/config-axios
  axios: {
    // Workaround to avoid enforcing hard-coded localhost:3000: https://github.com/nuxt-community/axios-module/issues/308
    baseURL: `${process.env.DEFAULT_URL}`,
  },
  auth: {
    redirect: {
        login: '/',
        logout: '/',
        callback: false,
        home: '/',
    },
    strategies: {
      local: {
        endpoints: {
          login: { url: '/api/v1/auth/sign_in', method: 'post', propertyName: 'access_token' },
          logout: { url: '/api/v1/auth/sign_out', method: 'delete' },
          user: false
        },
      }
    }
  },

  // Vuetify module configuration: https://go.nuxtjs.dev/config-vuetify
  vuetify: {
    // Doc: https://vuetifyjs.com/ja/customization/a-la-carte/
    treeShake: true,
    customVariables: ['~/assets/sass/variables.scss'],
    theme: {
      dark: false,
      themes: {
        light: {
          primary: colors.blue.darken2,
          accent: colors.grey.darken3,
          secondary: colors.amber.darken3,
          info: colors.teal.lighten1,
          warning: colors.amber.base,
          error: colors.deepOrange.accent4,
          success: colors.green.accent3,
          myblue: colors.blue.accent3
        },
      },
    },
  },
  i18n: {
    strategy: 'no_prefix',
    locales: ['ja', 'en'],
    defaultLocale: 'ja',
    // Doc: https://kazupon.github.io/vue-i18n/api/#properties
    vueI18n: {
      fallbackLocale: 'ja',
      // silentTranslationWarn: true,
      silentFallbackWarn: true,
      messages: {
        ja: require('./locales/ja.json'),
        en: require('./locales/en.json')
      }
    }
  },
  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {},
  publicRuntimeConfig: {
    appName: process.env.APP_NAME,
    guestEmail: process.env.GUEST_EMAIL,
    guestPass: process.env.GUEST_PASS,
    cryptoKey: process.env.CRYPTO_KEY,
    defaultUrl: process.env.DEFAULT_URL,
    redirectUrl: process.env.REDIRECT_URL,
    websocketEndpoint: process.env.WEBSOCKET_ENDPIONT,
    defaultImageUrl: process.env.DEFAULT_IMAGE_URL
  }
}
