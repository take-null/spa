class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  #dependent: :destroyユーザーの投稿をユーザーの破棄と同時に破棄するコード
  #チャット機能用のリレーション
  #has_many :chat_messages, dependent: :destroy
  #has_many :user_room, dependent: :destroy
  has_one_attached :image
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms
  #マイクロポスト用のリレーション
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  #以下フォロー機能
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

  #def follow(other_user)
    #self.relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  #end
  
  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  #def unfollow(other_user)
    #relationship = self.relationships.find_by(follow_id: other_user.id)
    #relationship&.destroy if relationship
  #end
  
  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
  #現在のユーザーがフォローされてたらtrueを返す
  def followers?(other_user)
    followers.include?(other_user)
  end


  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  #ユーザー新規作成時のみパスワードを入力必須にする
  validates :password, presence: true, on: :create
end
