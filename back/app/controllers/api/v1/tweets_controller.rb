module Api
  module V1
    class TweetsController < ApplicationController
      #認証に成功していなければ以下のアクション全てでリクエストに失敗する
      before_action :authenticate_api_v1_user!, only: [:index, :show, :create, :destroy]

      def index
        tweets = Tweet.all
        render json: { status: 'SUCCESS', message: 'Loaded tweets', data: tweets }
      end

      def show
        @tweet = Tweet.find(params[:id])
        @user = @tweet.user
        render json: { status: 'SUCCESS', message: 'Loaded the tweet', data: @tweet }
      end

      def create
        @tweet = Tweet.new(tweet_params)
        @tweet.user_id = current_user.id
        if @tweet.save
          render json: { status: 'SUCCESS', data: @tweet }
        else
          render json: { status: 'ERROR', data: @tweet.errors }
        end
      end
      
      #認証中のユーザーが自分と同一でないuser_idを持つtweetを削除した場合エラーになる
      def destroy
        @tweet = current_user.tweets.find(params[:id])
        @tweet.destroy
        if @tweet.destroy
          render json: { status: 'SUCCESS', message: 'Delete the tweet', data: @tweet }
        else
          render json: { status: 'ERROR', data: @tweet.errors }
        end
      end

      private
      #リファクタリング予定※show,deleteはfindメソッドを使用しなかった場合エラーとなる
      #def set_tweet
        #@tweet = Tweet.find_by(params[:id])
        #@tweet = Tweet.find(params[:id])
      #end 

      def tweet_params
        params.permit(:tweet_content)
        #params.require(:tweet).permit(:tweet_content)
        #params.require(:tweet).permit(:user_id, :tweet_content)
      end

    end
  end
end