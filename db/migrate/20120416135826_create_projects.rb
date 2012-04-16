class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string    :member_id
      t.string    :title
      t.string    :github_url
      t.text      :description
      t.string    :photo_url
      t.timestamps
    end
  end
end
