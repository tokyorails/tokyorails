class DropSpikes < ActiveRecord::Migration
  def up
    drop_table :spikes
  end

  def down
    create_table :spikes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
