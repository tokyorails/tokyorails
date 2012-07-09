class DropHtmlFromPrjects < ActiveRecord::Migration
  def up
    remove_column :projects, :html
    remove_column :project_translations, :html
  end

  def down
  end
end
