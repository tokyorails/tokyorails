class AddHtmlToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :html, :text
  end
end
