FactoryGirl.define do
  factory :admin_user do
    email    { generate(:email) }
    password "password"
    password_confirmation "password"
  end

  sequence :email do |n|
    "example_email#{n}@example.com"
  end
end
