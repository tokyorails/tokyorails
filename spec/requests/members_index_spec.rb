require 'spec_helper'

feature "Viewing users" do

  scenario "A list of registered users" do
    10.times do
      Factory(:member)
    end
    visit members_path
    page.should have_content("Group Members (#{Member.count}")
    Member.all.each do |member|
      page.should have_css("img", :src => "#{member.photo.thumb('90x90#').url}")
      page.should have_css("img", :alt => "#{member.name}")
    end
  end

end
