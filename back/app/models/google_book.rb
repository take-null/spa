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
      url = url_of_searching_from_keyword(keyword)
      Rails.logger.debug(url)

      uri = Addressable::URI.encode(url)
      Rails.logger.debug(uri)

      pars = URI.parse(uri)
      Rails.logger.debug(pars)

      response = Net::HTTP.get(pars)

      json = JSON.parse(response)
      Rails.logger.debug(json)

      items = json['items']
      return [] unless items
    
      items.map do |item|
        GoogleBook.new_from_item(item)
      end
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