class ProjectTranslation < ActiveRecord::Base
  belongs_to :project
  validates_uniqueness_of :locale, :scope => :project_id
end