FactoryGirl.define do
  factory :image do
    member_id
    file File.new(Rails.root.join('spec','fixtures','example.jpg'))
  end
end
