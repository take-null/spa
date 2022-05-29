class TweetsController < ApplicationController
  #before_action :logged_in_user, only: [:create, :destroy] 工事中 
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
  
    render json: messages_array, status: 200
  end

  def create
  end

  def destroy
  end

  private
    def tweet_params
      params.require(:tweet).permit(:tweet_content)
    end
end
