require 'spec_helper'

describe Event do
  context "given there are events on meetup.com" do

    WebMock.allow_net_connect!
    describe ".all" do
      it "returns a list of upcoming events" do
        events = Event.all(:params => { :key => Rails.application.config.meetup_com_api_key, :page => 100, :group_id => '2270561', :status => :upcoming  })
        events.size.should >= 1
      end

      it "returns a list of previous events" do
        events = Event.all(:params => { :key => Rails.application.config.meetup_com_api_key, :page => 100, :group_id => '2270561', :status => :past })
        events.size.should >= 3
      end
    end
  end
end
