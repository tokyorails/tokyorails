class AddHtmlToEvents < ActiveRecord::Migration
  def change
    add_column :events, :html, :text
  end
end
