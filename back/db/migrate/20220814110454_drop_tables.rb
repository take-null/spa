class DropTables < ActiveRecord::Migration[6.1]
  def change
    drop_table :active_storage_attachments do
    end
    drop_table :active_storage_blobs do
    end
    drop_table :active_storage_variant_records do
    end
    drop_table :hellos do
    end
    drop_table :likes do
    end
    drop_table :tweets do
    end
  end
end
