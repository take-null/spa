//本番環境用の設定
import axios from "axios"

//export default axios.create({
  //baseURL: "http://localhost:3000"
  //baseURL: "https://referer-hub-api.net" 
//})


/*デバッグ用
  export default ({ $axios }) => {
  // リクエストログ
  $axios.onRequest((config) => {
    console.log(config)
  })
  // レスポンスログ
  $axios.onResponse((config) => {
    console.log(config)
  })
  // エラーログ
  $axios.onError((e) => {
    console.log(e.response)
  })
}*/

export default function ({ $axios }) {
  $axios.onRequest((config) => {
    // Devise Token Auth
    //if (localStorage.getItem('token-type') === 'Bearer' && localStorage.getItem('access-token'))
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
      //localStorage.setItem('id', response.data.data.id)
      //オブジェクトにユーザーidを含ませる時に使う
      //localStorage.setItem('id', response.data.id)
      }
    }
  )
}