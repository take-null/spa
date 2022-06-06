class UserRoom < ApplicationRecord
  #userとroomの中間テーブル
  belongs_to :user
  belongs_to :room
end
