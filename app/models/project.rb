class Project < ActiveRecord::Base
  has_many :memberships
  has_many :members, :through => :memberships
  has_many :project_translations
  accepts_nested_attributes_for :memberships, :allow_destroy => true
  accepts_nested_attributes_for :project_translations, :allow_destroy => true

  translates :title, :description, :fallbacks_for_empty_translations => true
end
