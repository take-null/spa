class AddColumnGoogleBooksApiIdToBooksShelves < ActiveRecord::Migration[6.1]
  def change
    add_column :books_shelves, :google_books_api_id, :string
  end
end
