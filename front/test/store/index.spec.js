import { createLocalVue } from '@vue/test-utils'
import Vuex from 'vuex'
import * as index from '~/store/index'
import { cloneDeep } from 'lodash'
//import axios from 'axios'

//let url = ''
//let body = {}
//let mockError = false
//jest.mock('axios', () => ({
  //post: (_url, _body) => {
    //return new Promise((resolve) => {
      //if (mockError)
      //throw Error("Mock error")
      //url = _url
      //body = _body
      //resolve(true)
    //})
  //}
//}))

describe('actions', () => {
  test('setLoggedIn', () => {
    const localVue = createLocalVue()
    localVue.use(Vuex)
    const store = new Vuex.Store(cloneDeep(index))
    expect(store.state.loggedIn).toBe(false)
    store.commit('setLoggedIn', true)
    expect(store.state.loggedIn).toBe(true)
    store.commit('setLoggedIn', false)
    expect(store.state.loggedIn).toBe(false)
  })
  test('getCurrentUser', () => {
    const localVue = createLocalVue()
    localVue.use(Vuex)
    const store = new Vuex.Store(cloneDeep(index))
    expect(store.state.current.user).toBe(null)
    const user = {
      id: 0,
      provider: "email",
      uid: "sample@sample.com",
      allow_password_change: false,
      name: "testman",
      image: {
        url: "",
        thumb: {
          url: ""
        }
      },
      email: "sample@sample.com",
      profile: "テストメッセージです",
      age: "1",
      locate: "北海道",
      created_at: "2022-07-04T13:59:51.914Z",
      updated_at: "2022-08-22T14:42:27.778Z",
      following: [],
      followers: [],
      active_notifications: [],
      passive_notifications: [],
      goods: []
    }
    store.dispatch('getCurrentUser', user)
    expect(store.state.current.user).toEqual(user)
  })
})