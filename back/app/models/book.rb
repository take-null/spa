class Book < ApplicationRecord
  has_many :authors
  has_many :books_shelves
  has_many :users, through: :books_shelves
end
