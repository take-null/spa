module Api
  module V1
    class TweetsController < ApplicationController
      before_action :set_post, only: [:index, :show, :update, :destroy]
      before_action :authenticate_api_v1_user! 
      def index
        messages = Tweet.all
        message_array = messages.map do |message|
          {
            id: message.id,
            user_id: message.user.id,
            name: message.name,
            content: message.tweet_content,
            created_at: message.created_at
          }
        end
        render json: messages_array, status: 'SUCCESS'
      end

      def show
        @user = @tweet.user
        ison_data = {
          'post': @tweet,
          'user': {
            'name': @user.name,
            'image': @user.image
          }
        }
        render json: { status: 'SUCCESS', message: 'Loaded the post', data: json_data }
      end

      def create
        tweet = Tweet.new(tweet_params)
        if tweet.save
          render json: { status: 'SUCCESS', data: tweet }
        else
          render json: { status: 'ERROR', data: tweet.errors }
        end
      end

      def destroy
        @tweet.destroy
        render json: { status: 'SUCCESS', message: 'Delete the post', data: @tweet }
      end

      def update
      end


      private


      def set_post
        @tweet = Tweet.find(params[:id])
      end 

      def tweet_params
        params.require(:tweet).permit(:tweet_content, :user_id)
      end

    end
  end
end