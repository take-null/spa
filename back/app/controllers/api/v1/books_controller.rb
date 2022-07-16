module Api
  module V1
    class BooksController < ApplicationController
      def search
        #@q = GoogleBook.ransack(params[:q])
        books = GoogleBook.search(params[:keyword])
        render json: { status: 'SUCCESS', data: books }
      end

      def create
        google_book = GoogleBook.new_from_id(create_book_params[:google_books_id])
        if (@book = google_book.find_book_or_save)
          render json: { status: 'SUCCESS', data: google_book }
        else
          render json: { status: 'ERROR', data: google_book.errors }
        end
      end

      private

      def create_book_params
        params.permit(:google_books_api_id)
      end
    end
  end
end
