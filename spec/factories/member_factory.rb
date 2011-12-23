# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :member do
    sequence(:uid) {|n| n }
    sequence(:name) {|n| "User #{n}" }
    sequence(:bio) {|n| "Bio of user #{n}" }
    sequence(:github_username) {|n| "user#{n}" }
    photo_url 'http://localhost/photo.jpg'
    image
  end
end
