class Good < ApplicationRecord
  belongs_to :user
  belongs_to :books_shelf

  scope :filter_by_books_self, ->(books_shelf_id) { where(books_shelf_id: books_shelf_id) if books_shelf_id }
end
