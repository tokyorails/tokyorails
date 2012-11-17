# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Event do

  context "associations" do
    it { should have_many(:images) }
  end

  context "given there are events" do
    let!(:next_event)     { create(:event, :status => 'upcoming', :time => Time.now) }
    let!(:previous_event) { create(:event, :status => 'past', :time => 1.month.ago) }

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

    describe 'each event' do
      it "should be able to have images" do
        stub_request(:get, "localhost/photo1.jpg").to_return(:body => File.new(Rails.root.join('spec','fixtures','example.jpg')), :status => 200)
        stub_request(:get, "localhost/photo2.jpg").to_return(:body => File.new(Rails.root.join('spec','fixtures','example.jpg')), :status => 200)

        previous_event.images.create(:file_url => 'http://localhost/photo1.jpg')
        previous_event.images.create(:file_url => 'http://localhost/photo2.jpg')
        previous_event.images.size.should == 2
      end
    end
  end
end
