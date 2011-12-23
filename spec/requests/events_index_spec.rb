# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Event requests" do
 
  before(:each) do
    WebMock.reset!
    WebMock.disable_net_connect!
  end

  it "lists previous events" do
    stub_request(:get, api_url('upcoming')).to_return(:body => get_response('events_upcoming.json'))
    stub_request(:get, api_url('past')).to_return(:body => get_response('events_past.json'))
    visit events_path
    page.should have_content('TOKYO Rails #5 - 12/1/2011 @ COOKPAD')
    page.should have_content('41 attended')
    page.should have_content('December 01, 2011')
  end

  context "upcoming events" do

    before(:each) do
      WebMock.reset!
      WebMock.disable_net_connect!
      stub_request(:get, api_url('past')).to_return(:body => get_response('events_past.json'))
    end

    it "lists upcoming events" do
      stub_request(:get, api_url('upcoming')).to_return(:body => get_response('events_upcoming.json'))
      visit events_path
      page.should have_content('Tokyo Rails Upcoming Test Event')
    end

    it "displays a message when there are no upcoming events" do
      stub_request(:get, api_url('upcoming')).to_return(:body => get_response('events_no_upcoming.json'))
      visit events_path
      page.should have_content('The next meetup is not yet scheduled, but please register to get notified.')
    end
  
  end

  it "informs user meetup.com api is unavailable when received bad request error" do
    stub_request(:get, %r{https://api.meetup.com/2/events}).to_timeout
    visit events_path
    page.should have_content("Sorry, the meetup.com Events API is not available right now. Please check back a bit later.")
  end
  
end
