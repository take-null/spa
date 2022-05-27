class TweetsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @micropost
  end

  def destroy
  end

  private
    def tweet_params
      params.require(:tweet).permit(:tweet_message)
    end
end
