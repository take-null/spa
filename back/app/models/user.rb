class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  #dependent: :destroyユーザーの投稿をユーザーの破棄と同時に破棄するコード
  has_many :chat_messages, dependent: :destroy
  has_many :tweets, dependent: :destroy
  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true
end
