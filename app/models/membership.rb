class Membership < ActiveRecord::Base
  belongs_to :member
  belongs_to :project
  validates_uniqueness_of :member_id, scope: :project_id
  attr_accessible :project_id
end
