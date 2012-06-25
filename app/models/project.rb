class Project < ActiveRecord::Base
    has_many :project_translations
    accepts_nested_attributes_for :project_translations, :allow_destroy => true

    translates :title, :description, :html, :fallbacks_for_empty_translations => true
end
