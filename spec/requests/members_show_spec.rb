require 'spec_helper'

feature "Showing a member" do

  scenario "A Registered User's info" do
    @member = FactoryGirl.create(:member)

    visit member_path(:id => @member.id)
    page.should have_content("#{@member.name}")
    page.should have_css("img", :src => "#{@member.photo.thumb('150x150#').url}")
    page.should have_css("img", :alt => "#{@member.name}")
  end

end
