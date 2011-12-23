# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :image do
    file File.new(Rails.root.join('spec','fixtures','example.jpg'))
  end
end
