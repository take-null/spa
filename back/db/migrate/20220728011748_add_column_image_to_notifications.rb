class AddColumnImageToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :user_image, :string
  end
end
