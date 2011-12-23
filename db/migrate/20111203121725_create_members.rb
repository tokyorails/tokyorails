# -*- encoding : utf-8 -*-
class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :meetup_id
      t.string :name
      t.string :bio
      t.string :github_username
      t.string :photo_url
      t.timestamps
    end
    add_index :members, :meetup_id
  end
end
