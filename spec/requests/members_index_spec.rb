# -*- encoding : utf-8 -*-
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

  scenario "Searching for registered users" do
    member_a = Factory(:member, :name => "adam")
    member_b = Factory(:member, :name => "miles")
    visit members_path
    fill_in "query", :with => member_a.name
    click_on "Search"
    page.should have_selector("img[alt=#{member_a.name}]")
    page.should have_no_selector("img[alt=#{member_b.name}]")

    click_on "Show All"
    page.should have_selector("img[alt=#{member_a.name}]")
    page.should have_selector("img[alt=#{member_b.name}]")
  end
end
