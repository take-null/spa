class ChangeColumnAddNotnullOnChatMessages < ActiveRecord::Migration[6.1]
  def change
    change_column_null :chat_messages, :message, false
  end
end
