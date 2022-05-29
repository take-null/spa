class CreateTweets < ActiveRecord::Migration[7.0]
  def change
    create_table :tweets do |t|
      t.references :user, index: true, foreign_key: true, type: :integer
      t.text :tweet_content
      t.timestamps
    end
    add_index :tweets, [:user_id, :created_at]
  end
end
