class ChangeDataImageAndDescriptionAndInfoToBooks2 < ActiveRecord::Migration[6.1]
  def change
    change_column :books, :image, :string
    change_column :books, :description, :string
    change_column :books, :info, :string
  end
end
