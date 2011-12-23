# -*- encoding : utf-8 -*-
class Photo < ActiveResource::Base
  self.site = "https://api.meetup.com"
  self.timeout = 5
end
