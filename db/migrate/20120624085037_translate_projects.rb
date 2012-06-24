class TranslateProjects < ActiveRecord::Migration
    def self.up
      Project.create_translation_table!({
        :title => :string,
        :description => :text,
        :html => :text
      }, {
        :migrate_data => true
      })
    end
    def self.down
      Project.drop_translation_table! :migrate_data => true
    end
end
