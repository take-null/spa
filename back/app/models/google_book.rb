require 'google_books_api'

class GoogleBook
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations
  
  attribute :google_books_api_id, :string
  attribute :authors
  attribute :image, :string
  attribute :published_at, :date
  attribute :title, :string
  attribute :publisher, :string
  
  
  validates :google_books_api_id, presence: true
  validates :title, presence: true
  
  class << self
  #lib以下に作成したモジュールを使用する
  include GoogleBooksApi
  
    def new_from_item(item)
      @item = item
      @volume_info = @item['volumeInfo']
      new(
        google_books_api_id: @item['id'],
        authors: @volume_info['authors'],
        image: image_url,
        published_at: @volume_info['publishedDate'],
        title: @volume_info['title'],
        publisher: @volume_info['publisher'],
      )
    end
  
    def new_from_id(google_books_api_id)
      url = url_of_creating_from_id(google_books_api_id)
      item = get_json_from_url(url)
      new_from_item(item)
    end
  
    def search(keyword)
      #フロントエンドからのリクエストをuriに変換
      url = url_of_searching_from_keyword(keyword)
      #ログに書き込み
      Rails.logger.debug(url)

      #urlをエンコード
      enc = Addressable::URI.encode(url)
      #ログに書き込み
      Rails.logger.debug(enc)

      #uriに変換
      uri = URI.parse(enc)
      #ログに書き込み
      Rails.logger.debug(uri)
      
      #hostとポート番号をターミナルに出力
      #puts uri.host => www.googleapis.com
      #puts uri.port => 443

      require 'net/https'
      http = Net::HTTP.new(uri.host, uri.port)
      Rails.logger.debug(http)
      #http.use_ssl = true
      http.use_ssl = uri.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(uri.request_uri)
      #getリクエストが為されているかをlogに書き込む
      Rails.logger.debug(request)

      response = http.request(request)
      
      ###responseの詳細をlogに書き込む################################
      Rails.logger.debug(response)
      Rails.logger.debug(response.code)
      Rails.logger.debug(response.message)
      Rails.logger.debug(response.body['items'][0])
      ##############################################################

      ###例外発生時のデバッグ用#######################################
      begin
        #responseをlogに書き込む
        Rails.logger.debug(response.value)
      rescue => e
        #エラーログをlogに書き込む
        Rails.logger.debug(e.class) # => 例:Net::HTTPServerException
        Rails.logger.debug(e.message) # => 例:404 "Not Found"
      end
      ##############################################################

      #.bodyでresponseをstringに変換
      str = response.body

      #hashに変換
      json = JSON.parse(str)

      #hashからArrayを取り出す
      items = json['items']

      return [] unless items
    
      items.map do |item|
        GoogleBook.new_from_item(item)
      end

      ##################################一時的に以下をコメントアウト####################################
      #puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx Rails.logger.debug(url) development.logに記録される↓"
      #Rails.logger.debug(url)
      #以下はdocker-compose upを使用し、ターミナルにlogを表示する際に使う(使用時はコメントアウト(#)を外す事)
      #pp "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx url↓", url
      #if Rails.env.development? || Rails.env.test?
        #json = get_json_from_url(url)
      #else Rails.env.production?
        #json = get_json_from_url_with_ssl(url)
      #end
      #puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx Rails.logger.debug(json,development.logに記録される↓"
      #Rails.logger.debug(json)
      #以下はdocker-compose upを使用し、ターミナルにlogを表示する際に使う(使用時はコメントアウト(#)を外す事)
      #pp "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx json↓", json
      #items = json['items']
      #return [] unless items
  
      #items.map do |item|
        #GoogleBook.new_from_item(item)
      #end
      ##################################一時的に以下をコメントアウト####################################
    end
  
    private
  
    def image_url
      @volume_info['imageLinks']['smallThumbnail'] if @volume_info['imageLinks'].present?
    end

  end
  
  def save
    return false unless valid?
  
    book = build_book
    return false unless book.valid?
  
    ActiveRecord::Base.transaction do
      book.save
      if authors.present?
        authors.each.with_index do |author, index|
          author = book.authors.build(name: author)
          author.is_representative = index.zero?
          author.save
        end
      end
    end
    true
  end
  
  def find_book_or_save
    if Book.find_by(google_books_api_id: google_books_api_id) || save
      Book.find_by(google_books_api_id: google_books_api_id)
    else
      false
    end
  end
  
  private
  
  def build_book
    Book.new(
      google_books_api_id: google_books_api_id,
      published_at: published_at,
      title: title,
      image: image,
      publisher: publisher,
    )
  end
end