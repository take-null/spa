class CreateChatMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_messages do |t|
      t.references :user, index: true, foreign_key: true, type: :integer
      t.references :room, index: true, foreign_key: true, type: :integer
      t.text :chat_message_content

      t.timestamps
    end
    #add_index :chat_messages, [:user_id, :created_at]
  end
end
