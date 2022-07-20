module Api
    module V1
      class BooksShelvesController < ApplicationController

      def index
        @books_shelves = BooksShelf.includes(:book).where(user_id: current_api_v1_user)
        render json: @books_shelves.as_json(include: [{book: {}}])
      end

      def show
        @books_shelf = BooksShelf.includes(:book).find(params[:id])
        render json: @books_shelf.as_json(include: [{book: {}}])
      end

      def create
        @books_shelf = BooksShelf.new(books_shelf_params)
        @books_shelf.user_id = current_api_v1_user.id
        @book = Book.find_by(google_books_api_id: params[:google_books_api_id])
        @books_shelf.book_id = @book.id
        if @books_shelf.save
          render json: { status: 'SUCCESS', data: @books_shelf }
        else
          render json: { status: 'ERROR', data: @books_shelf.errors }
        end
      end

      private
      def books_shelf_params
        params.permit(:comment, :rating, :google_books_api_id)
      end
    end
  end
end
