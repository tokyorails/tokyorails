class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :member_id
      t.string :file_uid

      t.timestamps
    end
    add_index :images, :member_id
  end
end
