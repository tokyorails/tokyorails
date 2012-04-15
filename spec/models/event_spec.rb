# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Event do
  context "given there are events" do
    let!(:next_event)     { Factory(:event, :status => 'upcoming', :time => Time.now) }
    let!(:previous_event) { Factory(:event, :status => 'past', :time => 1.month.ago) }

    describe ".upcoming" do
      it "returns a list of upcoming events" do
        Event.upcoming.size.should == 1
      end
    end

    describe ".past" do
      it "returns a list of previous events" do
        Event.past.size.should > 0
      end
    end

    describe '.recent' do
      it "returns the events ordered by date, most recent first" do
        Event.recent.should == [next_event, previous_event]
      end
    end
  end
end
