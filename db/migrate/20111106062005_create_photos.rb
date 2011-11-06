class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :member_id
      t.string :file_uid

      t.timestamps
    end
    add_index :photos, :member_id
  end
end
