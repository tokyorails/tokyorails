require 'spec_helper'

feature "Viewing users" do
  API_MEMBERS_URL = "https://api.meetup.com/members.json?key=#{Rails.application.config.meetup_com_api_key}&page=100&group_id=2270561"
  API_MEMBERS_RESPONSE = '{
            "results": [
              {
                "zip": "12345",
                "lon": "139.77000427246094",
                "photo_url": "http://example.com/photos/member/1.jpg",
                "link": "http://www.meetup.com/members/1",
                "state": "",
                "lang": "en_US",
                "city": "Tokyo",
                "country": "jp",
                "id": "2836473",
                "visited": "2011-10-29 07:24:47 EDT",
                "topics": [ ],
                "joined": "Mon Aug 01 06:10:09 EDT 2011",
                "bio": "Rails Engineer.",
                "name": "Mr. Member",
                "other_services": {
                  "twitter": {
                    "identifier": "@example"
                  }
                },
                "lat": "35.66999816894531"
              }]
            }'

  scenario "A list of registered users" do
    stub_request(:get, API_MEMBERS_URL).
         with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => API_MEMBERS_RESPONSE, :headers => {})
    visit members_path
    page.should have_content('Group Members (1)')
    page.should have_css("img", :src => "#{Photo.last.thumb('90x90#').url}")
    page.should have_css("img", :alt => "Mr Member.")
  end

  scenario "Viewing members page when the meetup.com api returns a timeout" do
    stub_request(:get, API_MEMBERS_URL).to_timeout
    visit members_path
    page.should have_content("Sorry, the meetup.com API is not available right now. Please check back a bit later.")
  end

  scenario "Viewing members page when the meetup.com api returns a 400 Bad request" do
    stub_request(:get, API_MEMBERS_URL).to_return(:body => "Bad Request", :status => 400)
    visit members_path
    page.should have_content("Sorry, the meetup.com API is not available right now. Please check back a bit later.")
  end
end
