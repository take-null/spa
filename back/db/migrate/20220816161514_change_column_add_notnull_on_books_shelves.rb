class ChangeColumnAddNotnullOnBooksShelves < ActiveRecord::Migration[6.1]
  def change
    change_column_null :books_shelves, :google_books_api_id, false
  end
end
