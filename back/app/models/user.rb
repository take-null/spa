class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  mount_uploader :image, ImageUploader
  has_many :chat_messages, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms
  
  has_many :books, through: :books_shelves
  has_many :books_shelves, dependent: :destroy
  has_many :goods, dependent: :destroy
  #通知機能
  has_many :active_notifications, class_name: 'Notification', 
                                  foreign_key: 'visitor_id', 
                                  dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', 
                                   foreign_key: 'visited_id', 
                                   dependent: :destroy
  
  #フォロー機能
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end
  
  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
  #現在のユーザーがフォローされてたらtrueを返す
  def followers?(other_user)
    followers.include?(other_user)
  end
  #フォロー通知
  def create_notification_follow!(current_api_v1_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_api_v1_user.id, id, 'follow'])
    if temp.blank?
      notification = current_api_v1_user.active_notifications.new(
        user_name: current_api_v1_user.name,
        user_image: current_api_v1_user.image,
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  #ユーザー新規作成時のみパスワードを入力必須にする
  validates :password, presence: true, on: :create
end