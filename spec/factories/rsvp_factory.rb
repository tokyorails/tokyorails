FactoryGirl.define do
  factory :rsvp do
    member_id { generate(:member_id) }
  end

  sequence :member_id do |n|
    n
  end
end
