module Api
  module V1
    class RelationshipsController < ApplicationController
      before_action :set_user
      
      def create
        if  @current_user.id == current_api_v1_user.id
          user = current_api_v1_user.follow(@other_user)
          @other_user.create_notification_follow!(current_api_v1_user)
          render json: user, status: 200
        else
          render json: { status: 400 }
        end
      end
      
      def destroy
        if  @current_user.id == current_api_v1_user.id
          user = current_api_v1_user.unfollow(@other_user)
          render json: user, status: 200
        else
          render json: { status: 400 }
        end 
      end

    private
      def set_user
        @current_user = User.find(params[:user_id])
        @other_user = User.find(params[:followed_id])
      end      
    end
  end
end
