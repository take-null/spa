class ChatMessage < ApplicationRecord
  #userとroomの中間にあり、メッセージを格納するもの
  belongs_to :user
  belongs_to :room
  has_many :notifications, dependent: :destroy

  validates :message, presence: true
  validates :message, length: { maximum: 140 }

  def template
    ApplicationController.renderer.render partial: 'api/v1/chat_messages/chat_message', locals: { chat_message: self }
  end
end
