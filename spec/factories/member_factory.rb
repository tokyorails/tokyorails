FactoryGirl.define do
  factory :member do
    sequence(:meetup_id) {|n| n }
    sequence(:name) {|n| "User #{n}" }
    sequence(:bio) {|n| "Bio of user #{n}" }
    sequence(:github_username) {|n| "user#{n}" }
    photo_url 'http://localhost/photo.jpg'
    image
  end
end