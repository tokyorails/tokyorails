Factory.define :rsvp do |f|
  f.member_id { Factory.next(:member_id) }
end

Factory.sequence :member_id do |n|
  n
end
