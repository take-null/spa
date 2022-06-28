import { strategies } from "@nuxtjs/auth/lib/module/defaults"
// Doc: https://www.npmjs.com/package/crypto-js
const cryptoJs = require('crypto-js')
const storage = window.localStorage
const keys = { expiry: 'expiry' }

class Authentication {
  constructor (ctx) {
    this.store = ctx.store
    this.$axios = ctx.$axios
    this.$auth = ctx.$auth
    this.error = ctx.error
    this.$config = ctx.$config
  }
  setStorage (expiry) {
    storage.setItem(keys.expiry, this.encrypt(expiry))
  }
  encrypt (expiry) {
    const expire = String(expiry * 1000)
    return cryptoJs.AES.encrypt(expire, this.$config.cryptoKey).toString()
  }
  decrypt (expiry) {
    try {
      const bytes = cryptoJs.AES.decrypt(expiry, this.$config.cryptoKey)
      return bytes.toString(cryptoJs.enc.Utf8) || this.removeStorage()
    } catch (e) {
      return this.removeStorage()
    }
  }
  removeStorage () {
    for (const key of Object.values(keys)) {
      storage.removeItem(key)
    }
  }
  getExpire () {
    const expire = storage.getItem(keys.expiry)
    return expire ? this.decrypt(expire) : null
    //return storage.getItem(keys.expiry)
  }
  isAuthenticated () {
    return new Date().getTime() < this.getExpire()
  }
  get user () {
    return this.store.state.current.user || {}
  }
  isUserPresent () {
    return ('id' in this.user)
  }
  get loggedIn () {
    return this.isUserPresent() && this.isAuthenticated()
  }
  //uidは暫定処置。nameに変更予定。
  setData (user) {
    this.store.dispatch('getCurrentUser', user)
  }
  //logout pageは改良の必要性あり？
  deleteData () {
    localStorage.removeItem("access-token")
    localStorage.removeItem("client")
    localStorage.removeItem("uid")
    localStorage.removeItem("token-type")
    localStorage.removeItem("expiry")
    localStorage.removeItem("id")
    this.store.dispatch('getCurrentUser', null)
  }
}

export default ({ store, $axios, $auth, error, $config }, inject) => {
    inject('nxauth', new Authentication({ store, $axios, $auth, error, $config }))
}