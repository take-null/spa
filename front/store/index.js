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
  }
}