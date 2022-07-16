class ChangeDataImageAndDescriptionAndInfoToBooks < ActiveRecord::Migration[6.1]
  def change
    change_column :books, :image, :text
    change_column :books, :description, :text
    change_column :books, :info, :text
  end
end
