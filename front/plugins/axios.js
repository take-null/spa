//本番環境用の設定
import axios from "axios"

export default axios.create({
  //baseURL: "http://localhost:3000"
  baseURL: "https://referer-hub-api.net" 
})


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