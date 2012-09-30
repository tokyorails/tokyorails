class Project < ActiveRecord::Base
  has_many :memberships, :dependent => :destroy
  has_many :members, through: :memberships, conditions: 'memberships.deleted_at IS NULL', order: 'memberships.id ASC'
  has_many :alumni, through: :memberships, source: :member, conditions: 'memberships.deleted_at IS NOT NULL', order: 'memberships.deleted_at DESC'
  has_many :project_translations
  accepts_nested_attributes_for :memberships, :allow_destroy => true
  accepts_nested_attributes_for :project_translations, :allow_destroy => true

  translates :title, :description, :fallbacks_for_empty_translations => true
end
