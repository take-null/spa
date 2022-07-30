module Api
  module V1
    class BooksShelvesController < ApplicationController
      include Pagenation
      #マイページ用
      def index
        @books_shelves = BooksShelf.includes(:book, :goods).where(user_id: current_api_v1_user).order("created_at DESC").page(params[:page]).per(5)
        pagenation = resources_with_pagenation(@books_shelves)
        booksShelves_array = @books_shelves.map do |booksShelf|
         {
           id: booksShelf.id,
           user_id: booksShelf.user_id,
           book_id: booksShelf.book_id,
           google_books_api_id: booksShelf.book.google_books_api_id,
           book_image: booksShelf.book.image,
           title: booksShelf.book.title,
           publisher: booksShelf.book.publisher,
           published_at: booksShelf.book.published_at,
           authors: booksShelf.book.authors[0],
           rating: booksShelf.rating,
           comment: booksShelf.comment,
           created_at: booksShelf.created_at,
           good: booksShelf.goods.select(:id, :user_id, :books_shelf_id).map 
          }
        end
        object = { books: booksShelves_array, kaminari: pagenation }
        render json: object
      end
      #他人のページ用
      def user
        @books_shelves = BooksShelf.includes(:book, :goods).where(user_id: params[:id]).order("created_at DESC")
        booksShelves_array = @books_shelves.map do |booksShelf|
         {
            id: booksShelf.id,
            user_id: booksShelf.user_id,
            book_id: booksShelf.book_id,
            google_books_api_id: booksShelf.book.google_books_api_id,
            book_image: booksShelf.book.image,
            title: booksShelf.book.title,
            publisher: booksShelf.book.publisher,
            published_at: booksShelf.book.published_at,
            authors: booksShelf.book.authors[0],
            rating: booksShelf.rating,
            comment: booksShelf.comment,
            created_at: booksShelf.created_at,
            good: booksShelf.goods.select(:id, :user_id, :books_shelf_id).map
          }
        end
        render json: booksShelves_array, status: 200
      end
      #タイムライン用
      def all
        @books_shelves = BooksShelf.includes(:book, :user, :tags, :goods).order("created_at DESC").page(params[:page]).per(5)
        pagenation = resources_with_pagenation(@books_shelves)
        booksShelves_array = @books_shelves.map do |booksShelf|
          {
            id: booksShelf.id,
            user_id: booksShelf.user_id,
            user_image: booksShelf.user.image.thumb.url,
            user_name: booksShelf.user.name,
            google_books_api_id: booksShelf.book.google_books_api_id,
            book_image: booksShelf.book.image,
            title: booksShelf.book.title,
            rating: booksShelf.rating,
            comment: booksShelf.comment,
            created_at: booksShelf.created_at,
            tags: booksShelf.tags.select(:id, :name, :taggings_count).map,
            good: booksShelf.goods.select(:id, :user_id, :books_shelf_id).map
          }
        end
        object = { books: booksShelves_array, kaminari: pagenation }
        render json: object
      end
      #タイムラインのタグフィールド表示用
      def tag
        @tag = BooksShelf.tags_on(:tags)
        render json: @tag, status: 200
      end
      #検証用
      def show
        @books_shelf = BooksShelf.find(params[:id])
        @tags = @books_shelf.tag_counts_on(:tags)
        render json: @books_shelf, status: 200
      end
      #タイムラインのランキング用
      def rank
        @books_shelves = BooksShelf.includes(:book)
        booksShelves_array = @books_shelves.map do |booksShelf|
          {
            google_books_api_id: booksShelf.book.google_books_api_id,
            book_image: booksShelf.book.image,
            title: booksShelf.book.title,
          }
        end
        books_array = booksShelves_array.group_by { |e| e }.sort_by { |e| -e[1].length }.map(&:first)
        new_books_array = []
        10.times do |i|
          books_array[i][:rank] = "#{i + 1}位"
          new_books_array << books_array[i]
        end
        render json: new_books_array
      end
      #タグ検索用
      def search
        @books_shelves = BooksShelf.includes(:book, :user, :goods).tagged_with(params[:tag]).order("created_at DESC")
        booksShelves_array = @books_shelves.map do |booksShelf|
          {
            id: booksShelf.id,
            user_id: booksShelf.user_id,
            user_image: booksShelf.user.image.thumb.url,
            user_name: booksShelf.user.name,
            google_books_api_id: booksShelf.book.google_books_api_id,
            book_image: booksShelf.book.image,
            title: booksShelf.book.title,
            rating: booksShelf.rating,
            comment: booksShelf.comment,
            created_at: booksShelf.created_at,
            tags: booksShelf.tags.select(:id, :name, :taggings_count).map,
            good: booksShelf.goods
          }
        end
        render json: booksShelves_array, status: 200
      end
      #ランキング検索用
      def view
        @books_shelves = BooksShelf.includes(:book, :user).where(google_books_api_id: params[:google_books_api_id]).order("created_at DESC")
        booksShelves_array = @books_shelves.map do |booksShelf|
          {
            id: booksShelf.id,
            user_id: booksShelf.user_id,
            user_image: booksShelf.user.image.thumb.url,
            user_name: booksShelf.user.name,
            google_books_api_id: booksShelf.book.google_books_api_id,
            book_image: booksShelf.book.image,
            title: booksShelf.book.title,
            rating: booksShelf.rating,
            comment: booksShelf.comment,
            created_at: booksShelf.created_at,
          }
        end
        render json: booksShelves_array, status: 200
      end
      
      #レビュー作成用
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
        params.permit(:comment, :rating, :google_books_api_id, :tag_list => [])
      end
    end
  end
end
