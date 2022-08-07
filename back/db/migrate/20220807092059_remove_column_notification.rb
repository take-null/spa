class RemoveColumnNotification < ActiveRecord::Migration[6.1]
  def change
    remove_column :notifications, :room_id
    remove_column :notifications, :chat_message_id
  end
end
