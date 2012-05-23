class AddIndexToImages < ActiveRecord::Migration
  def change
    add_index :images, [ :imageable_id, :imageable_type]
  end
end
