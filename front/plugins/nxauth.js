import { strategies } from "@nuxtjs/auth/lib/module/defaults"

const storage = window.localStorage
const keys = { expiry: 'expiry' }

class Authentication {
  constructor (ctx) {
    this.store = ctx.store
    this.$axios = ctx.$axios
    this.$auth = ctx.$auth
  }
  //setStorage (expiry) {
    //localstorageを見て不要なら下記の計算式を削除
    //storage.setItem(expiry, expiry * 1000 )
  //}
  removeStorage () {
    for (const key of Object.values(keys)) {
      storage.removeItem(key)
    }
  }
  getExpire () {
    return storage.getItem(keys.expiry)
  }
  isAuthenticated () {
    return new Date().getItem() < this.getExpire()
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
    this.store.dispatch('getCurrentUser', null)
  }
}

export default ({ store, $axios, $auth }, inject) => {
    inject('nxauth', new Authentication({ store, $axios, $auth }))
}