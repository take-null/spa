class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  default_scope -> { order('created_at DESC') }
  validates :tweet_content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  def liked?(user)
    likes.where(user_id: user.id).exists?
  end
end
