class AddUidToImages < ActiveRecord::Migration
  def change
    add_column :images, :uid, :string
    add_index :images, :uid
  end
end
