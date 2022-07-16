class RemoveColumnDescriptionAndInfoToBooks < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :description, :string
    remove_column :books, :info, :string
  end
end
