class AddDeletedAtToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :deleted_at, :timestamp
  end
end
