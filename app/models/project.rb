class Project < ActiveRecord::Base
  has_many :memberships, :dependent => :destroy
  has_many :members, through: :memberships, conditions: 'memberships.deleted_at IS NULL', order: 'memberships.id ASC'
  has_many :alumni, through: :memberships, source: :member, conditions: 'memberships.deleted_at IS NOT NULL', order: 'memberships.deleted_at DESC'
  has_many :project_translations
  accepts_nested_attributes_for :memberships, :allow_destroy => true
  accepts_nested_attributes_for :project_translations, :allow_destroy => true

  translates :title, :description, :fallbacks_for_empty_translations => true

  def leader?(member)
    memberships.where(member_id: member).first.leader?
  end

  def active_members
    actives = []
    members.each do |member|
      actives << member if member.active?
    end
    actives
  end

  def noshows
    members - active_members
  end

  def active?
    active_members.size > 0
  end
end
