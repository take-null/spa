module Api
  module V1
    class RoomsController < ApplicationController
      # before_action :authenticate_api_v1_user!, only: [:index, :show]
      # before_action :set_user, only: [:index, :show]

      def index
        rooms = current_api_v1_user.rooms.order(created_at: :desc)
        rooms_array = rooms.map do |room|
          {
            id: room.id,
            current_user: room.users.where(id: current_api_v1_user.id)[0],
            other_user: room.users.where.not(id: current_api_v1_user.id)[0],
            last_message: room.chat_messages[-1]
          }
        end
        render json: rooms_array, status: :ok
      end

      def create
        isRoom = false
        my_entry = UserRoom.where(user_id: current_api_v1_user.id)
        other_entry = UserRoom.where(user_id: params[:id])
        my_entry.each do |me|
          other_entry.each do |oe|
            isRoom = true if me.room_id == oe.room_id
          end
        end
        if isRoom
          my_entry = UserRoom.where(user_id: current_api_v1_user.id)
          other_entry = UserRoom.where(user_id: params[:id])
          my_entry.each do |me|
            other_entry.each do |oe|
              if me.room_id == oe.room_id
                room = Room.find_by(id: me.room_id)
                render json: room, status: :ok
              end
            end
          end
        else
          room = Room.create
          UserRoom.create(room_id: room.id, user_id: current_api_v1_user.id)
          UserRoom.create(room_id: room.id, user_id: params[:id])
          room = Room.find_by(id: room.id)
          render json: room, status: :ok
        end
      end

      def show
        room = Room.find_by(id: params[:id])
        current_user = room.users.where(id: current_api_v1_user.id)[0]
        other_user = room.users.where.not(id: current_api_v1_user.id)[0]
        render json: { room_id: room.id, current_user: current_user, other_user: other_user, status: 200 }
      end

      def messages
        room = Room.find_by(id: params[:id])
        messages = room.chat_messages.order(created_at: :asc)
        render json: messages, status: :ok
      end
    end
  end
end
