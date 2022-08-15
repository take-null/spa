import axios from "axios"

//export default axios.create({
  //baseURL: "http://localhost:3000"
  //baseURL: "https://referer-hub-api.net" 
//})

//認証機能が正常に作動しないときはブラウザのキャッシュが溜まっているためクリアする事
export default function ({ $axios }) {
  $axios.onRequest((config) => {
    // Devise Token Auth
      config.headers.common.uid = localStorage.getItem('uid')
      config.headers.common.client = localStorage.getItem('client')
      config.headers.common['access-token'] = localStorage.getItem('access-token')
      //console.log(config.headers.common)
    }
  )

  $axios.onResponse((response) => {
    // Devise Token Auth
    if (response.headers['access-token']) {
        localStorage.setItem('token-type', response.headers['token-type'])
        localStorage.setItem('uid', response.headers.uid)
        localStorage.setItem('client', response.headers.client)
        localStorage.setItem('access-token', response.headers['access-token'])
        //console.log(response.headers)
      }
    }
  )
}