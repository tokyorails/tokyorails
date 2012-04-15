class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string    :name
      t.string    :uid
      t.string    :status
      t.string    :address
      t.text      :description
      t.datetime  :time
      t.integer   :yes_rsvp_count
      t.timestamps
    end
    add_index :events, :uid
  end
end
