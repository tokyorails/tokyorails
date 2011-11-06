class Member < ActiveResource::Base
  self.site = "https://api.meetup.com"
  self.timeout = 5

  def photo
    Photo.where(:member_id => id).first || Photo.create(:member_id => id, :file_url => photo_url) unless photo_url.blank?
  end
end
