module Api
  module V1
    class ChatMessagesController < ApplicationController
      #before_action :authenticate_api_v1_user!, only: [:index, :create]

      def index
        messages = ChatMessage.all
        message_array = messages.map do |message|
          {
            id: message.id,
            user_id: message.user.id,
            content: message.chat_message_content,
            created_at: message.created_at
          }
        end
      render json: message_array, status: 200
      end

      def create
        @chat_message = ChatMessage.create!(message_params)
        #render json: { status: 'SUCCESS', data: @chat_message }
      end

    private
      def message_params
        #params.permit(:chat_message_content)
        #params.permit(:chat_message_content, :room_id, :user_id)
        params.require(:chat_message).permit(:chat_message_content, :room_id, :user_id)
      end
    end
  end
end
