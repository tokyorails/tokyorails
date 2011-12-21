require 'spec_helper'

describe Event do
  context "given there are events on meetup.com" do
  
    before(:each) do
      WebMock.reset!
      WebMock.disable_net_connect!
    end

    # Just make sure that events exist for .upcoming and .past (i.e the HTTP
    # request is made) Any more than that and we start re-testing ActiveResource
    describe ".upcoming" do
      it "returns a list of upcoming events" do
        stub_request(:get, api_url('upcoming')).to_return(:body => get_response('events_upcoming.json'))       
        events = Event.upcoming
        events.size.should > 0        
      end

      it "returns nil in case of API timeout" do
        stub_request(:get, api_url('upcoming')).to_timeout
        events = Event.upcoming
        events.should == nil
      end

      it "returns nil in case of bad request" do
        stub_request(:get, api_url('upcoming')).to_return(:status => 400)
        events = Event.upcoming
        events.should == nil
      end      
    end    

    describe ".past" do
      it "returns a list of previous events" do
        stub_request(:get, api_url('past')).to_return(:body => get_response('events_past.json'))        
        events = Event.past
        events.size.should > 0
      end

      it "returns nil in case of API timeout" do
        stub_request(:get, api_url('past')).to_timeout
        events = Event.past
        events.should == nil
      end

      it "returns nil in case of bad request" do
        stub_request(:get, api_url('upcoming')).to_return(:status => 400)
        events = Event.upcoming
        events.should == nil
      end       
    end

    describe ".date" do
      it "should return the date of an event" do
        stub_request(:get, api_url('upcoming')).to_return(:body => get_response('events_upcoming.json'))
        Event.upcoming.first.date.should == Date.parse('Thu, 01 Sep 2011')
      end
    end
  end
end
