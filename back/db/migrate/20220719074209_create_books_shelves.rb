class CreateBooksShelves < ActiveRecord::Migration[6.1]
  def change
    create_table :books_shelves do |t|
      t.references :user, index: true, foreign_key: true, type: :integer
      t.references :book, index: true, foreign_key: true, type: :integer
      t.text :comment, null: false
      t.integer :rating, null: false
      t.timestamps
    end
    add_index :books_shelves, [:user_id, :book_id, :created_at]
  end
end
