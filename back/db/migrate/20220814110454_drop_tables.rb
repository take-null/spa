class DropTables < ActiveRecord::Migration[6.1]
  def change
    drop_table :active_storage_attachments do
    end
    drop_table :active_storage_variant_records do
    end
    drop_table :active_storage_blobs do
    end
  end
end
