module Api
  module V1
    class UsersController < ApplicationController
      #before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
      def index
        @user = User.all
        render json: @user, status: :ok
      end

      def show
        @user = correct_user
        #@tweets = @user.tweets.paginate(page: params[:page])
        render json: @user, status: :ok
      end

      def destroy
        @user = correct_user
        if @user.destroy
          render json: user
        else
          render json: { status: 400 }
        end
      end

      private
      def correct_user
        @user = User.find(params[:id])
      end

    end
  end
end
