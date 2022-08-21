module Api
  module V1
    class UsersController < ApplicationController
      #before_action :authenticate_api_v1_user!
      #before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
      
      #def index
      # @users = User.includes(:following, 
      #                        :followers, 
      #                        ).where.not(id: current_api_v1_user.id).order(:id)
      #  render json: @users.as_json(include: [{following: {except: [:uid, :email]}},
      #                                        {followers: {except: [:uid, :email]}}]), status: 200
      #end

      def search
        @user = User.includes(:following,
                              :followers,
                              :active_notifications, 
                              :passive_notifications,
                              :goods 
                             ).find_by(email: params[:email])
        render json: @user.as_json(include: [{following: {except: [:uid, :email]}}, 
                                             {followers: {except: [:uid, :email]}}, 
                                             {active_notifications: {}}, 
                                             {passive_notifications: {}},
                                             {goods: {}}]), status: 200
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

      #def destroy
      #  @user = correct_user
      #  if @user.destroy
      #    render json: @user, status: 200
      #  else
      #    render json: { status: 400 }
      #  end
      #end

      private

      def correct_user
        @user = User.find(params[:id])
      end

    end
  end
end