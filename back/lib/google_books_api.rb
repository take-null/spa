module GoogleBooksApi
  def url_of_creating_from_id(google_books_api_id)
    "https://www.googleapis.com/books/v1/volumes/#{google_books_api_id}"
  end
  #Google Books APIのIDから、APIのURLを取得する
  
  def url_of_searching_from_keyword(keyword)
    "https://www.googleapis.com/books/v1/volumes?q=#{keyword}&country=JP"
  end
  #キーワードから、検索するAPIのURLを取得する
  

  #500エラー発生につき使用停止
  #def get_json_from_url(url)
  #  uri = Addressable::URI.encode(url)
  #  prs = URI.parse(uri)
  #  response = Net::HTTP.get(prs)
  #  JSON.parse(response)
  #end
  #URLから、JSON文字列を取得し、JSONオブジェクトを構築する
end