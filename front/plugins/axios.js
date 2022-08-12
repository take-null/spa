import axios from "axios"

//export default axios.create({
  //baseURL: "http://localhost:3000"
  //baseURL: "https://referer-hub-api.net" 
//})

export default function ({ $axios }) {
  $axios.onRequest((config) => {
    // Devise Token Auth
    if (localStorage.getItem('access-token')) {
      config.headers.uid = localStorage.getItem('uid')
      config.headers.client = localStorage.getItem('client')
      config.headers['access-token'] = localStorage.getItem('access-token')
    }
  })

  $axios.onResponse((response) => {
    // Devise Token Auth
    if (response.headers['token-type'] === 'Bearer' && response.headers['access-token']) {
      localStorage.setItem('token-type', response.headers['token-type'])
      localStorage.setItem('uid', response.headers.uid)
      localStorage.setItem('client', response.headers.client)
      localStorage.setItem('access-token', response.headers['access-token'])
      }
    }
  )
}