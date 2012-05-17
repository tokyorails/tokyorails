class AddImageableToImages < ActiveRecord::Migration
  def self.up
    change_table :images do |t|
      t.references :imageable, :polymorphic => true
      execute "UPDATE `images` SET imageable_id = member_id WHERE imageable_id IS NULL"
      execute "UPDATE `images` SET imageable_type = 'Member' WHERE imageable_type IS NULL"
      t.remove_index :member_id
      t.remove :member_id
    end
  end
  
  def self.down
    change_table :images do |t|
      t.remove_references :imageable, :polymorphic => true
    end
  end
end