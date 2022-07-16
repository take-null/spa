class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.references :book, foreign_key: true
      t.string :name, null: false
      t.boolean :is_representative, null: false

      t.timestamps
    end
  end
end
