class Tweet < ApplicationRecord
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :tweet_content, presence: true, length: { maximum: 140 }
end
