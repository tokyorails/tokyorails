Factory.define(:admin_user) do |admin|
  admin.email    { Factory.next(:email) }
  admin.password "password"
  admin.password_confirmation "password"
end

Factory.sequence :email do |n|
  "example_email#{n}@example.com"
end
