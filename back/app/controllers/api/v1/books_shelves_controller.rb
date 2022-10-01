module Api
  module V1
    class BooksShelvesController < ApplicationController
      include Pagenation
      include CreateArray
      # マイページ用
      def index
        @books_shelves = BooksShelf.includes(:book, :tags,
                                             :goods).where(user_id: current_api_v1_user).order(created_at: :desc).page(params[:page]).per(12)
        pagenation = resources_with_pagenation(@books_shelves)
        booksShelves_array = create_user_page_array(@books_shelves)
        object = { books: booksShelves_array, kaminari: pagenation }
        render json: object, status: :ok
      end

      # マイページ削除用
      def destroy
        @books_shelf = BooksShelf.find(params[:id])
        render json: @books_shelf, status: :ok if @books_shelf.destroy
      end

      # 他人のページ用
      def user
        @books_shelves = BooksShelf.includes(:book, :tags,
                                             :goods).where(user_id: params[:id]).order(created_at: :desc).page(params[:page]).per(12)
        pagenation = resources_with_pagenation(@books_shelves)
        booksShelves_array = create_user_page_array(@books_shelves)
        object = { books: booksShelves_array, kaminari: pagenation }
        render json: object, status: :ok
      end

      # タイムライン用
      def all
        @books_shelves = BooksShelf.includes(:book, :user, :tags, :goods).order(created_at: :desc).page(params[:page]).per(5)
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
        render json: object, status: :ok
      end

      # タイムラインのタグフィールド表示用
      def tag
        @tag = BooksShelf.tags_on(:tags)
        render json: @tag, status: :ok
      end

      # 検証用
      def show
        @books_shelf = BooksShelf.find(params[:id])
        @tags = @books_shelf.tag_counts_on(:tags)
        render json: @books_shelf, status: :ok
      end

      # タイムラインのランキング用
      def rank
        @books_shelves = BooksShelf.includes(:book)
        booksShelves_array = @books_shelves.map do |booksShelf|
          {
            google_books_api_id: booksShelf.book.google_books_api_id,
            book_image: booksShelf.book.image,
            title: booksShelf.book.title
          }
        end
        books_array = booksShelves_array.group_by { |e| e }.sort_by { |e| -e[1].length }.map(&:first)
        new_books_array = []
        books_array.length.times do |i|
          books_array[i][:rank] = "#{i + 1}位"
          new_books_array << books_array[i]
        end
        render json: new_books_array, status: :ok
      end

      # タグ検索用
      def search
        @books_shelves = BooksShelf.includes(:book, :user, :goods).tagged_with(params[:tag]).order(created_at: :desc)
        booksShelves_array = create_search_result_array(@books_shelves)
        render json: booksShelves_array, status: :ok
      end

      # ランキング検索用
      def view
        @books_shelves = BooksShelf.includes(:book, :user,
                                             :goods).where(google_books_api_id: params[:google_books_api_id]).order(created_at: :desc)
        booksShelves_array = create_search_result_array(@books_shelves)
        render json: booksShelves_array, status: :ok
      end

      # レビュー作成用
      def create
        @books_shelf = current_api_v1_user.books_shelves.new(books_shelf_params)
        @book = Book.find_by(google_books_api_id: params[:google_books_api_id])
        @books_shelf.book_id = @book.id
        if @books_shelf.save
          render json: @books_shelf, status: :ok
        else
          render json: @books_shelf.errors, status: :internal_server_error
        end
      end

      private

      def books_shelf_params
        params.permit(:comment, :rating, :google_books_api_id, tag_list: [])
      end
    end
  end
end
