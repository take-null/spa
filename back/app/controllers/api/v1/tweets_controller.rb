module Api
  module V1
    class TweetsController < ApplicationController
      before_action :set_tweet, only: [:index, :show, :update, :destroy]
      #認証に成功していなければ以下のアクションにリクエスト出来ない
      before_action :authenticate_api_v1_user! 
      def index
        tweets = Tweet.all
        render json: { status: 'SUCCESS', message: 'Loaded tweets', data: tweets }
      end

      def show
        @user = @tweet.user
        json_data = {
          'post': @tweet,
          'user': {
            'name': @user.name,
            'image': @user.image
          }
        }
        render json: { status: 'SUCCESS', message: 'Loaded the tweet', data: json_data }
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
        render json: { status: 'SUCCESS', message: 'Delete the tweet', data: @tweet }
      end

      def update
      end


      private


      def set_tweet
        @tweet = Tweet.find_by(params[:id])
      end 

      def tweet_params
        params.require(:tweet).permit(:tweet_content, :user_id)
      end
    end
  end
end