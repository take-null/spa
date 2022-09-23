class CreateSurveys < ActiveRecord::Migration[6.1]
  def change
    create_table :surveys do |t|
      t.references :user, index: true, foreign_key: true, type: :integer
      t.string :title, null: false
      t.string :content, null: false
      t.timestamps
    end
  end
end
