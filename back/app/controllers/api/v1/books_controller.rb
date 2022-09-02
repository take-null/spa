module Api
  module V1
    class BooksController < ApplicationController
      def search
        books = GoogleBook.search(params[:keyword])
        #google_booksモデルはgoogle_books_apiを読み込み、外部通信を要するurl_of_searching_from_keywordとget_json_from_urlメソッドを使用する。
        #本searchメソッドの上記booksインスタンスはgoogle_booksモデルが作動していなければ、下記のdebugで内容が表示されない。
        #すなわち以下のRails.logger.debugはapiの外部通信及びgoogle_booksモデルのテストを兼ねている。
        #ログにbooks_arrayの内容が表示される場合は「正常」と判断して良い。
        books_array = books.map do |book|
          { 
            google_books_api_id: book.google_books_api_id,
            image: book.image,
            published_at: book.published_at,
            title: book.title,
            publisher: book.publisher,
            authors: book.authors
          }
        end
        books_array.each do |i|
          if i[:authors] != nil
            i[:authors] = i[:authors].sort.join(',')
          end
        end
        Rails.logger.debug "url_of_searching_from_keyword ok #{books_array[0]}"
        render json: books_array, status: 200
      end

      def create
        google_book = GoogleBook.new_from_id(create_book_params[:google_books_api_id])
        if (@book = google_book.find_book_or_save)
          render json: google_book, status: 200
        else
          render json: google_book.errors, status: 500
        end
      end

      private

      def create_book_params
        params.permit(:google_books_api_id)
      end
    end
  end
end
