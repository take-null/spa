module Api
  module V1
    class GoodsController < ApplicationController
      before_action :authenticate_api_v1_user!, only: [:create, :destroy]
      before_action :set_good
  
      def create
        @good = Good.new(user_id: current_api_v1_user.id, books_shelf_id: @books_shelf_id.id)
        if @good.save
          @books_shelf.create_notification_good!(current_api_v1_user)
          render json: { status: 'SUCCESS', data: @good }
        else
          render json: { status: 'ERROR', data: @good.errors }
        end
      end
  
      def destroy
        @good.delete
        if @good.destroy
          render json: { status: 'SUCCESS', message: 'Delete the good', data: @good }
        else
          render json: { status: 'ERROR', data: @good.errors }
        end
      end
  
      private
      def set_good
        @books_shelf = BooksShelf.find(params[:books_shelf_id])
      end
    end
  end
end
