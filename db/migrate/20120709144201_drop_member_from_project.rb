class DropMemberFromProject < ActiveRecord::Migration
  def up
    remove_column :projects, :member_id
  end

  def down
  end
end
