module Api
  module V1
    class UsersController < ApplicationController
      #before_action :authenticate_api_v1_user!
      #before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
      
      def index
        users = User.includes(:following, 
                              :followers, 
                              ).where.not(id: current_api_v1_user.id).order(:id)
        render json: users.as_json(include: [{following: {except: [:uid, :email]}},
                                             {followers: {except: [:uid, :email]}}])
      end

      def search
        @user = User.includes(:following,
                              :followers,
                              :active_notifications, 
                              :passive_notifications 
                             ).find_by(email: params[:email])
        render json: @user.as_json(include: [{following: {except: [:uid, :email]}}, 
                                             {followers: {except: [:uid, :email]}}, 
                                             {active_notifications: {}}, 
                                             {passive_notifications: {}}])
      end

      def show
        @user = User.includes(:following, :followers).find(params[:id])
        #@users = @user.following
        #@user = correct_user
        #@tweets = @user.tweets
        #@tweets = @user.tweets.paginate(page: params[:page])
        render json: @user.as_json(include: [{following: {except: [:uid, :email]}},
                                             {followers: {except: [:uid, :email]}}])
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