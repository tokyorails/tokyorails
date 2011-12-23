class RenameMembersMeetupId < ActiveRecord::Migration
  def change
    remove_index :members, :meetup_id
    rename_column :members, :meetup_id, :uid
    add_index :members, :uid
  end
end
