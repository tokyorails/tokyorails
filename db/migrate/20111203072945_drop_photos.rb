# -*- encoding : utf-8 -*-
class DropPhotos < ActiveRecord::Migration
  def up
    drop_table :photos
  end

  def down
    create_table :photos do |t|
      t.string :member_id
      t.string :file_uid

      t.timestamps
    end
    add_index :photos, :member_id
  end
end
