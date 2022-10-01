module Api
  module V1
    class GoodsController < ApplicationController
      # before_action :authenticate_api_v1_user!, only: [:create, :destroy]
      before_action :set_good, only: [:create]

      def index
        render json: Good.filter_by_books_self(params[:books_shelf_id]).select(:id, :user_id, :books_shelf_id), status: :ok
      end

      def create
        @good = current_api_v1_user.goods.create!(goods_params)
        if @good.save
          @books_shelf.create_notification_good!(current_api_v1_user)
          render json: @good, status: :ok
        else
          render json: @good.errors, status: :internal_server_error
        end
      end

      def destroy
        @good = Good.find(params[:id])
        if @good.destroy
          render json: @good, status: :ok
        else
          render json: @good.errors, status: :internal_server_error
        end
      end

      private

      def goods_params
        params.permit(:books_shelf_id)
      end

      def set_good
        @books_shelf = BooksShelf.find(params[:books_shelf_id])
      end
    end
  end
end
