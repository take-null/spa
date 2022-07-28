export const state = () => ({
  loggedIn: false,
  current: {
    user: null
  },
  styles: {
    beforeLogin: {
      appBarHeight: 56
    }
  }
})
  
export const getters = {}
  
export const mutations = {
  setLoggedIn (state, payload) {
    state.loggedIn = payload
  },
  setCurrentUser (state, payload) {
    state.current.user = payload
  },
  deleteNotice (state, id) {
    if (state.current.user.passive_notifications.length === 1) {
      state.current.user.passive_notifications = null
      this.$router.go({path: this.$router.currentRoute.path, force: true})
    } else {
      var targetId = id;
      state.current.user.passive_notifications.some(function(v, i) {
        if (v.id==targetId) state.current.user.passive_notifications.splice(i, 1);
      });
    }
  }
}
 
export const actions = {
  login ({ commit }) {
    commit('setLoggedIn', true)
  },
  logout ({ commit }) {
    commit('setLoggedIn', false)
  },
  //uidは暫定処置
  getCurrentUser ({ commit }, user ) {
    commit('setCurrentUser', user)
  },
  
}