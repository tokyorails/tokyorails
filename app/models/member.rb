# -*- encoding : utf-8 -*-
class Member < ActiveRecord::Base

  include Tokyorails::GithubMethods

  validates_presence_of :uid, :name, :bio
  validates_uniqueness_of :uid
  validates_uniqueness_of :github_username, :allow_blank => true

  has_one :image, :as => :imageable, :dependent => :destroy
  has_many :memberships
  has_many :projects, :through => :memberships

  scope :authenticated, where("access_token IS NOT NULL AND access_token != ''")
  scope :name_like, lambda {|query| where("UPPER(name) LIKE UPPER(?)", "%#{query}%")}

  def self.authenticate(auth)
    member = Member.find_by_uid(auth['uid'].to_s)
    if member
      member.access_token = auth['credentials']['token']
      member.save!
    end
    member
  end

  def photo
    self.image || self.create_image(:file_url => photo_url) unless photo_url.blank?
  end

  def toggle_membership(project_id)
    member_of?(project_id) ? memberships.find_by_project_id(project_id).destroy : memberships.create!(:project_id => project_id)
  end

  def member_of?(project_id)
    memberships.find_by_project_id(project_id).present?
  end

  def interests
    [] # coming from somewhere
  end

end
