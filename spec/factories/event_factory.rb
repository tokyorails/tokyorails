FactoryGirl.define do
  factory :event do
    uid  { generate(:uid) }
    name { generate(:name) }
    status  'past'
    time 5.days.ago
    yes_rsvp_count 3
    description '<p>Please RSVP for this event</p>'
    html '<p>Additional HTML</p>'
  end

  sequence :uid do |n|
    n
  end

  sequence :name do |n|
    "Meetup #{n}"
  end
end
