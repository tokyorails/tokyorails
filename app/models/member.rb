class Member < ActiveRecord::Base

  validates_presence_of :meetup_id, :name, :bio
  validates_uniqueness_of :meetup_id
  validates_uniqueness_of :github_username, :allow_blank => true

#  has_one :image

  def photo
    Image.where(:member_id => id).first || Image.create(:member_id => id, :file_url => photo_url) unless photo_url.blank?
  end
end
