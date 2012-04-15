class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.string    :uid
      t.string    :member_id
      t.string    :meetup_id
      t.string    :response
      t.integer   :guests
      t.datetime  :modified_at
      t.timestamps
    end
    add_index :rsvps, :uid
  end
end
