class CreateGoods < ActiveRecord::Migration[6.1]
  def change
    create_table :goods do |t|
      t.references :user, index: true, foreign_key: true, type: :integer
      t.references :books_shelf, index: true, foreign_key: true, type: :integer

      t.timestamps
    end
  end
end
