class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  #dependent: :destroyユーザーの投稿をユーザーの破棄と同時に破棄するコード
  #チャット機能用のリレーション
  #has_many :chat_messages, dependent: :destroy
  #has_many :user_room, dependent: :destroy

  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms
  #マイクロポスト用のリレーション
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  #ユーザー新規作成時のみパスワードを入力必須にする
  validates :password, presence: true, on: :create
end
