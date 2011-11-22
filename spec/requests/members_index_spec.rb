require 'spec_helper'

feature "Viewing users" do
  API_MEMBERS_URL = "https://api.meetup.com/members.json?key=#{Rails.application.config.meetup_com_api_key}&page=100&group_id=2270561"

  use_vcr_cassette
  scenario "A list of registered users" do
    visit members_path
    page.should have_content('Group Members (')
    page.should have_css("img", :src => "#{Photo.last.thumb('90x90#').url}")
    page.should have_css("img", :alt => "Mr Member.")
  end

  scenario "Viewing members page when the meetup.com api returns a timeout" do
    stub_request(:get, API_MEMBERS_URL).to_timeout
    visit members_path
    page.should have_content("Sorry, the meetup.com Members API is not available right now. Please check back a bit later.")
  end

  scenario "Viewing members page when the meetup.com api returns a 400 Bad request" do
    stub_request(:get, API_MEMBERS_URL).to_return(:body => "Bad Request", :status => 400)
    visit members_path
    page.should have_content("Sorry, the meetup.com Members API is not available right now. Please check back a bit later.")
  end
end
