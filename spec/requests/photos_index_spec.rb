# -*- encoding : utf-8 -*-
require 'spec_helper'

feature "Viewing photos" do
  API_PHOTOS_URL = "https://api.meetup.com/photos.json?key=#{Rails.application.config.meetup_com_api_key}&page=100&group_id=2270561"

  use_vcr_cassette
  scenario "A list of photos" do
    visit photos_path
    page.should have_content('Photos')
    page.should have_css("img", :alt => "meetup photo")
  end

  scenario "Viewing photos page when the meetup.com api returns a timeout" do
    stub_request(:get, API_PHOTOS_URL).to_timeout
    visit photos_path
    page.should have_content("Sorry, the meetup.com Photos API is not available right now. Please check back a bit later.")
  end

  scenario "Viewing photos page when the meetup.com api returns a 400 Bad request" do
    stub_request(:get, API_PHOTOS_URL).to_return(:body => "Bad Request", :status => 400)
    visit photos_path
    page.should have_content("Sorry, the meetup.com Photos API is not available right now. Please check back a bit later.")
  end
end
