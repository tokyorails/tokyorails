# -*- encoding : utf-8 -*-
require 'spec_helper'

feature "Showing a member" do

  scenario "renders a registered user's info" do
    @member = create(:member)

    visit member_path(:id => @member.id)
    page.should have_content("#{@member.name}")
    page.should have_css("img", :src => "#{@member.photo.thumb('150x150#').url}")
    page.should have_css("img", :alt => "#{@member.name}")
  end

end
