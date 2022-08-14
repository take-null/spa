module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_api_v1_user!, only: [:index, :search, :show, :destroy]
      
      def index
        users = User.includes(:following, :followers).where.not(id: current_api_v1_user.id).order(:id)
        render json: users.as_json(include: [{following: {except: [:uid, :email]}},
                                             {followers: {except: [:uid, :email]}}])
      end

      def search
        @user = User.includes(:following, :followers, :active_notifications, :passive_notifications, :goods).find_by(email: params[:email])
        render json: @user.as_json(include: [{following: {except: [:uid, :email]}}, 
                                             {followers: {except: [:uid, :email]}}, 
                                             {active_notifications: {}}, 
                                             {passive_notifications: {}},
                                             {goods: {}}])
      end

      def show
        @user = User.includes(:following, :followers, :goods).find(params[:id])
        render json: @user.as_json(include: [{following: {except: [:uid, :email]}},
                                             {followers: {except: [:uid, :email]}},
                                             {goods: {}}])
      end

      def destroy
        @user = correct_user
        if @user.destroy
          render json: user, status: 200
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