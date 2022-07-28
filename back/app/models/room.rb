class Room < ApplicationRecord
  #ユーザーが保有するチャットルーム
  #has_many :user_rooms, dependent: destroy
  #has_many :chat_messages, dependent: destroy
  has_many :chat_messages, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms
  has_many :notifications, dependent: :destroy
  def create_notification_comment!(current_api_v1_user, chat_message_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = ChatMessage.select(:user_id).where(chaat_message_id: id).where.not(user_id: current_api_v1_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_api_v1_user, chat_message_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_api_v1_user, chat_message_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_api_v1_user, chat_message_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      room_id: id,
      chat_message_id: chat_message_id,
      visited_id: visited_id,
      action: 'chat_message'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
