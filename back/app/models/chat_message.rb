class ChatMessage < ApplicationRecord
  #userとroomの中間にあり、メッセージを格納するもの
  belongs_to :user
  belongs_to :room

  validates :chat_message_content, presence: true
  validates :chat_message_content, length: { maximum: 140 }
end
