class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :user, index: true, foreign_key: true, type: :integer
      t.references :tweet, index: true, foreign_key: true, type: :integer

      t.timestamps
    end
  end
end
