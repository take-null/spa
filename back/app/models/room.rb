class Room < ApplicationRecord
  #ユーザーが保有するチャットルーム
  has_many :chat_messages, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms
end
