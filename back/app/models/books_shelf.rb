class BooksShelf < ApplicationRecord
  acts_as_taggable
  belongs_to :user
  belongs_to :book
  has_many :goods, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def create_notification_good!(current_api_v1_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and books_shelf_id = ? and action = ? ", current_api_v1_user.id, user_id, id, 'good'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_api_v1_user.active_notifications.new(
        user_name: current_api_v1_user.name,
        user_image: current_api_v1_user.image,
        books_shelf_id: id,
        visited_id: user_id,
        action: 'good'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
