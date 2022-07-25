class BooksShelf < ApplicationRecord
  acts_as_taggable
  belongs_to :user
  belongs_to :book
end
