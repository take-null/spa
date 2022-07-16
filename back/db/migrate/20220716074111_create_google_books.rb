class CreateGoogleBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :google_books do |t|

      t.timestamps
    end
  end
end
