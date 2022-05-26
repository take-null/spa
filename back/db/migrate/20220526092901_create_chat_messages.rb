class CreateChatMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_messages do |t|
      t.references :user, index: true, foreign_key: true, type: :integer
      t.text :content
      t.timestamps
    end
  end
end
