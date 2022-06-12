class RenameRoomNameColumnToRooms < ActiveRecord::Migration[6.1]
  def change
    rename_column :rooms, :room_name, :name
  end
end
