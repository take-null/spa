class CreateUserRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :user_rooms do |t|
      t.references :user, index: true, foreign_key: true, type: :integer
      t.references :room, index: true, foreign_key: true, type: :integer
      
      t.timestamps
    end
  end
end
