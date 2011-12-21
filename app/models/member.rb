class Member < ActiveRecord::Base

  include Tokyorails::GithubMethods

  validates_presence_of :meetup_id, :name, :bio
  validates_uniqueness_of :meetup_id
  validates_uniqueness_of :github_username, :allow_blank => true

  has_one :image

  def photo
    self.image || self.create_image(:file_url => photo_url) unless photo_url.blank?
  end
  
  def interests
    [] # coming from somewhere
  end
  
end
