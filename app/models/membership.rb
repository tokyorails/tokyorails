class Membership < ActiveRecord::Base
  belongs_to :member
  belongs_to :project
  validates_uniqueness_of :member_id, scope: :project_id, :unless => :retired?
  attr_accessible :project_id, :member_id, :leader

  scope :active, where(deleted_at: nil)

  def retire
    update_attribute(:deleted_at, Time.now)
  end

  def retired?
    deleted_at != nil
  end
end
