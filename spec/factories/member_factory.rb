FactoryGirl.define do
  factory :member do
    uid  { generate(:uid) }
    name { generate(:name) }
    bio 'my bio'
    github_username { generate(:github_username) }
    photo_url 'http://localhost/photo.jpg'
    image
  end

  sequence :github_username do |n|
    "github_#{n}"
  end
end
