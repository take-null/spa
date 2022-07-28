class AddColumnNameToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :user_name, :string, default: "", null: false
  end
end
