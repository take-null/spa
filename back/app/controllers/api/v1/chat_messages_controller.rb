module Api
  module V1
    class ChatMessagesController < ApplicationController
      #before_action :authenticate_api_v1_user!, only: [:index, :create]

      #def index
        #messages = ChatMessage.all
        #message_array = messages.map do |message|
          #{
            #id: message.id,
            #user_id: message.user.id,
            #content: message.chat_message_content,
            #created_at: message.created_at
          #}
        #end
      #render json: message_array, status: 200
      #end

      def create
        @chat_message = ChatMessage.create!(message_params)
        @room = Room.find_by(id: message_params[:room_id])
        RoomChannel.broadcast_to(@room, message: @chat_message.template)
        #render json: { status: 'SUCCESS', data: @chat_message }
      end

    private

      def message_params
        params.require(:chat_message).permit(:message, :room_id, :user_id)
      end
    end
  end
end
