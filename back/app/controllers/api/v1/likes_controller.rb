module Api
  module V1
    class LikesController < ApplicationController
      before_action :authenticate_api_v1_user!, only: [:create, :destroy]
      before_action :set_like

      def create
        @like = Like.new(user_id: current_api_v1_user.id, tweet_id: @tweet.id)
        if @like.save
          render json: { status: 'SUCCESS', data: @like }
        else
          render json: { status: 'ERROR', data: @like.errors }
        end
      end

      def destroy
        @like.delete
        if @like.destroy
          render json: { status: 'SUCCESS', message: 'Delete the like', data: @like }
        else
          render json: { status: 'ERROR', data: @like.errors }
        end
      end

      private
      def set_like
        @tweet = Tweet.find(params[:tweet_id])
      end
    end
  end
end
