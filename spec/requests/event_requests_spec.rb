require 'spec_helper'

describe "Event requests" do
  it "lists previous events" do
    VCR.use_cassette("events_past", :record => :once) do
      visit events_path
      page.should have_content('Previous Events (3)')
      page.should have_content('COOKPAD on Rails #2')
    end
  end

  it "lists upcoming events" do
    VCR.use_cassette("events_upcoming", :record => :once) do
      visit events_path
      page.should have_content('Upcoming Events (1)')
      page.should have_content('TOKYO Rails #5 - 12/1/2011 @ COOKPAD')
    end
  end

  it "informs user meetup.com api is unavailable when received bad request error" do
    VCR.use_cassette("events_bad_request", :record => :once) do
      stub_request(:get, %r{https://api.meetup.com/2/events}).to_timeout
      visit events_path
      page.should have_content("Sorry, the meetup.com Events API is not available right now. Please check back a bit later.")
    end
  end
end
