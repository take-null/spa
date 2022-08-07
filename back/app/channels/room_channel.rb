class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_#{params[:room]}"
  end

  def unsubscribed
  end

  def receive(data)
    if message = ChatMessage.create(message: data['message'], user_id: data['user_id'], room_id: data['id'])
      ActionCable.server.broadcast "room_#{data['id']}", message
    end
  end
end
