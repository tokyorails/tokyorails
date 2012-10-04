class AddLeadToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :leader, :boolean
  end
end
