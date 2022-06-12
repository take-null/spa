class RenameChatMessageContentColumnToChatMessages < ActiveRecord::Migration[6.1]
  def change
    rename_column :chat_messages, :chat_message_content, :message
  end
end
