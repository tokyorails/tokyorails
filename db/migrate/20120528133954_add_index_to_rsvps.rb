class AddIndexToRsvps < ActiveRecord::Migration
  def change
    add_index :rsvps, [ :meetup_id, :response]
  end
end
