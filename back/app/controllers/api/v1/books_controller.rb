module Api
  module V1
    class BooksController < ApplicationController
      def search
        #@q = GoogleBook.ransack(params[:q])
        books = GoogleBook.search(params[:keyword])
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
        render json: books_array, status: 200
      end

      def create
        google_book = GoogleBook.new_from_id(create_book_params[:google_books_api_id])
        if (@book = google_book.find_book_or_save)
          render json: { status: 200, data: google_book }
        else
          render json: { status: 500, data: google_book.errors }
        end
      end

      private

      def create_book_params
        params.permit(:google_books_api_id)
      end
    end
  end
end
