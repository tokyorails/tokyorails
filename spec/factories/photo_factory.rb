FactoryGirl.define do
  factory :photo do
    member_id
    file File.new(Rails.root.join('spec','fixtures','example.jpg'))
  end
end
