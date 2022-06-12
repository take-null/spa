#class Api::V1::RoomsController < ApplicationController
class Api::V1::RoomsController < ActionController::Base
  #before_action :authenticate_api_v1_user!, only: [:index, :show]
  before_action :set_user, only: [:index, :show]

  def index
    @rooms = @user.rooms.all
    #render json: { status: 'SUCCESS', message: 'Loaded rooms', data: @rooms }
  end

  def show
    @room = @user.rooms.find(params[:id])
    @chat_messages = @room.chat_messages.order(created_at: :desc).limit(10)
    @chat_message = @room.chat_messages.build
    #render json: { status: 'SUCCESS', message: 'Loaded rooms', data: @room }
    #render json: { status: 'SUCCESS', message: 'Loaded rooms', data: @chat_messages }
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end
end