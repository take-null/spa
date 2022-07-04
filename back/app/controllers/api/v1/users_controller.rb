module Api
  module V1
    class UsersController < ApplicationController
      #before_action :authenticate_api_v1_user!
      #before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
      
      def index
        users = User.all.order(:id)
        render json: users.as_json(only: [:id, :email, :image, :name, :profile, :age, :locate, :created_at])
      end

      def search
        #users = User.all
        @user = User.find_by(email: params[:email])
        render json: @user.as_json(only: [:id, :image, :name, :profile, :age, :locate, :created_at])
      end

      def show
        @user = User.find(params[:id])
        #@user = correct_user
        #@tweets = @user.tweets
        #@tweets = @user.tweets.paginate(page: params[:page])
        render json: @user.as_json(only: [:id, :image, :name, :profile, :age, :locate, :created_at])
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
