class ChatMessagesController < ApplicationController
  #工事中
  def index
    messages = ChatMessage.all
    message_array = messages.map do |message|
      {
        id: message.id,
        user_id: message.user.id,
        name: message.name,
        content: message.content,
        created_at: message.created_at
      }
    end

    render json: messages_array, status: 200
  end
end
