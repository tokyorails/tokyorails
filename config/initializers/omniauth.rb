# -*- encoding : utf-8 -*-
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :meetup, ENV['MEETUP_KEY'], ENV['MEETUP_SECRET']
end
