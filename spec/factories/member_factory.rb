Factory.define :member do |f|
  f.uid  { Factory.next(:uid) }
  f.name { Factory.next(:name) }
  f.bio 'my bio'
  f.github_username { Factory.next(:github_username) }
  f.photo_url 'http://localhost/photo.jpg'
  f.image
end

Factory.sequence :github_username do |n|
  "github_#{n}"
end
