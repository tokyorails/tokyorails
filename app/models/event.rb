class Event < ActiveResource::Base
  self.site = "https://api.meetup.com"
  self.prefix = "/2/"
  self.timeout = 5
end
