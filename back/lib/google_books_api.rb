module GoogleBooksApi
  def url_of_creating_from_id(google_books_api_id)
    "https://www.googleapis.com/books/v1/volumes/#{google_books_api_id}"
  end
  #Google Books APIのIDから、APIのURLを取得する
  
  def url_of_searching_from_keyword(keyword)
    "https://www.googleapis.com/books/v1/volumes?q=#{keyword}&country=JP"
  end
  #キーワードから、検索するAPIのURLを取得する
  

  
  def get_json_from_url(url)
    #urlをエンコード
    enc = Addressable::URI.encode(url)
    #uriに変換
    uri = URI.parse(enc)
    #hostとポート番号をターミナルに出力
    #puts uri.host => www.googleapis.com
    #puts uri.port => 443
    #puts uri.request_uri => /books/v1/volumes?q=%E6%A4%9C%E7%B4%A2&country=JP
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == 'https'
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    #getリクエストを行うためのインスタンスを生成
    request = Net::HTTP::Get.new(uri.request_uri)
    #googleapisにgetリクエスト
    response = http.request(request)
    ###例外発生時のデバッグ用#######################################
    #begin
      #responseをlogに書き込む(本番用)
      #Rails.logger.debug(response.value)
    #rescue => e
      #エラーログをlogに書き込む(本番用)
      #Rails.logger.debug(e.class) # => 例:Net::HTTPServerException
      #Rails.logger.debug(e.message) # => 例:404 "Not Found"
    #end
    ##############################################################
    
    ###疎通確認用##################################################
    #require 'net/ping'
    ## Pingの宛て先はuri.host(www.googleapis.com)
      #pinger = Net::Ping::External.new(uri.host)
      ## Pingが通るかどうかテストします
      #Rails.logger.debug(pinger.ping?)
    ##############################################################
    
    #.bodyでresponseをstringに変換
    str = response.body
    #hashに変換
    JSON.parse(str)
  end
  #URLから、JSON文字列を取得し、JSONオブジェクトを構築する
end