# -*- encoding : utf-8 -*-
require 'spec_helper'

feature "Authenticating members" do
  before(:each) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:meetup, :uid => 654321, :credentials => {:token => "aeo127"})
  end

  context "With an existing Meetup.com account" do
    scenario "authenticates on our site" do
      member = Factory(:member, :meetup_id => 654321)
      visit root_path
      click_link('Member Login')
      Member.last.access_token.should == 'aeo127'
      current_path.should == root_path
    end
  end

end
