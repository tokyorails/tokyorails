# -*- encoding : utf-8 -*-
require 'spec_helper'

feature "Member Authentication" do
  before(:each) do
    OmniAuth.config.test_mode = true
  end

  context "Logged out member with an existing Meetup.com account" do
    scenario "authenticates on our site" do
      OmniAuth.config.add_mock(:meetup, :uid => 654321, :credentials => {:token => "aeo127"})
      member = Factory(:member, :uid => 654321)
      visit root_path
      page.should_not have_content('My Profile')
      click_link('Member Login')
      Member.last.access_token.should == 'aeo127'
      current_path.should == root_path
      page.should have_content('My Profile')
      page.should have_content('Logout')
    end
  end

  context "Logged in member" do
    scenario "logs out of the site" do
      OmniAuth.config.add_mock(:meetup, :uid => 654321, :credentials => {:token => "aeo127"})
      member = Factory(:member, :uid => 654321)
      visit root_path
      click_link('Member Login')
      current_path.should == root_path
      page.should have_content('My Profile')
      click_link('Logout')
      page.should_not have_content('My Profile')
      page.should have_content('Member Login')
    end
  end

  context "Login failure" do
    scenario "tries to log in" do
      OmniAuth.config.mock_auth[:meetup] = :invalid_credentials
      visit root_path
      click_link('Member Login')
      current_path.should == root_path
      page.should_not have_content('My Profile')
      page.should have_content('Member Login')
    end
  end
end
