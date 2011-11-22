require 'spec_helper'

describe "Event requests" do
  use_vcr_cassette

  it "lists previous events" do
    visit events_path
    page.should have_content('Previous Events (3)')
    page.should have_content('COOKPAD on Rails #2')
  end

  it "lists upcoming events" do
    visit events_path
    page.should have_content('TOKYO Rails #5 - 12/1/2011 @ COOKPAD')
  end

  it "informs user meetup.com api is unavailable when received bad request error" do
    stub_request(:get, %r{https://api.meetup.com/2/events}).to_timeout
    visit events_path
    page.should have_content("Sorry, the meetup.com Events API is not available right now. Please check back a bit later.")
  end
end
