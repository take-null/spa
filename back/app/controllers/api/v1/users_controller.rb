module Api
  module V1
    class UsersController < ApplicationController
      #before_action :authenticate_api_v1_user!, only: [:destroy] 
      
      def index
       @users = User.all.includes(:following, 
                                  :followers, 
                                 ).where.not(id: current_api_v1_user.id).order(:id)
        render json: @users.as_json(include: [{following: {except: [:uid, :email]}},
                                              {followers: {except: [:uid, :email]}}]), status: 200
      end

      def search
        @user = User.includes(:following,
                              :followers,
                              :active_notifications, 
                              :passive_notifications,
                              :goods,
                              :surveys 
                             ).find_by(email: params[:email])
        render json: @user.as_json(include: [{following: {except: [:uid, :email]}}, 
                                             {followers: {except: [:uid, :email]}}, 
                                             {active_notifications: {}}, 
                                             {passive_notifications: {}},
                                             {goods: {}},
                                             {surveys: {}}]), status: 200
      end

      def show
        @user = User.includes(:following,
                              :followers,
                              :goods
                             ).find(params[:id])
        render json: @user.as_json(include: [{following: {except: [:uid, :email]}},
                                             {followers: {except: [:uid, :email]}},
                                             {goods: {}}]), status: 200
      end

      def destroy
        @user = User.find(params[:id])
        if @user.destroy
          render json: { status: 200 }
        else
          render json: { status: 400 }
        end
      end

    end
  end
end