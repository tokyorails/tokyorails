class CreateSpikes < ActiveRecord::Migration
  def change
    create_table :spikes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
