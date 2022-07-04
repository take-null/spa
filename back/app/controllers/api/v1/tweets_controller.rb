module Api
  module V1
    class TweetsController < ApplicationController
      #認証に成功していなければ以下のアクション全てでリクエストに失敗する
      #before_action :authenticate_api_v1_user!, only: [:all, :index, :show, :create, :destroy]
      #before_action :set_user, only: [:index]

      #def all_post
        #@tweets = Tweet.all
        #render json: { status: 'SUCCESS', message: 'Loaded tweets', data: tweets }
      #end
      #自分の投稿だけ表示
      def all
        tweets = Tweet.all.includes(:user).order("created_at DESC")
        tweet_array = tweets.map do |tweet|
          {
            tweet_id: tweet.id,
            id: tweet.user.id,
            name: tweet.user.name,
            content: tweet.tweet_content,
            created_at: tweet.created_at
          }
        end
        render json: { status: 'SUCCESS', message: 'Loaded the tweet', data: tweet_array }
      end

      def index
        tweets = Tweet.where(user_id: current_api_v1_user.id).includes(:user).order("created_at DESC")
        tweet_array = tweets.map do |tweet|
          {
            tweet_id: tweet.id,
            user_id: tweet.user.id,
            name: tweet.user.name,
            content: tweet.tweet_content,
            created_at: tweet.created_at
          }
        end
        #render json: { status: 'SUCCESS', message: 'Loaded the tweet', data: tweet_array }
        render json: { status: 'SUCCESS', message: 'Loaded the tweet', id: "#{current_api_v1_user.id}", data: tweet_array }
        #render json: { status: 'SUCCESS', message: 'Loaded tweets', data: @tweets}
      end
      
      def show
        @tweet = Tweet.find(params[:id])
        #@user = @tweet.user
        render json: { status: 'SUCCESS', message: 'Loaded the tweet', data: @tweet }
      end

      def create
        @tweet = Tweet.new(tweet_params)
        @tweet.user_id = current_api_v1_user.id
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
      #def set_user
        #current_user = User.find_by(params[:id])
        #@tweet = Tweet.find(params[:id])
      #end
      #end 

      def tweet_params
        params.permit(:tweet_content)
        #params.require(:tweet).permit(:tweet_content)
        #params.require(:tweet).permit(:user_id, :tweet_content)
      end

    end
  end
end