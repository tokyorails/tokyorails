# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Tokyorails::MeetupTasks do

  context '.import_members' do

    before(:each) do
      WebMock.reset!
      WebMock.disable_net_connect!
      stub_request(:get, /.*/).to_return(:body => get_response('members.json'))
      Tokyorails::MeetupTasks.import_members
      WebMock.reset!
    end

    it 'should create new members' do
      Member.count.should == 2
    end

    it 'should update existing members if their meetup profile is newer than their member record' do
      stub_request(:get, /.*/).to_return(:body => get_response('members_future.json'))
      Tokyorails::MeetupTasks.import_members
      Member.first.name.should == 'Adam Akhtar Updated'
      Member.last.name.should == 'Rémi Updated'
    end

    it 'should not update existing members if their meetup profile is not newer than their member record' do
      stub_request(:get, /.*/).to_return(:body => get_response('members_past.json'))
      Tokyorails::MeetupTasks.import_members
      Member.first.name.should == 'Adam Akhtar'
      Member.last.name.should == 'Rémi'
    end

    it 'should delete the member photo if the photo URL has changed' do
      stub_request(:get, /.*photos.*/).to_return(:body => File.new(Rails.root.join('spec','fixtures','example.jpg')))
      Member.first.photo.should_not be_nil

      stub_request(:get, /.*/).to_return(:body => get_response('members_new_photo.json'))
      Tokyorails::MeetupTasks.import_members
      Member.first.image.should be_nil
    end

    it 'should import members with ISO 8859-1 characters in their data' do
      Member.last.name.should == 'Rémi'
    end

    it 'should set the github_username if the member has a github account specified in meetup' do
      Member.first.github_username.should == 'robodisco'
    end

    it 'should not set the github_username if the member does not have a github account specified in meetup' do
      Member.last.github_username.should be_nil
    end

    it 'should remove members no longer in the meetup group' do
      stub_request(:get, /.*/).to_return(:body => get_response('members_one.json'))
      Tokyorails::MeetupTasks.import_members
      Member.count.should == 1
      Member.first.name.should == 'Adam Akhtar'
    end

    it 'should do nothing if an exception is encountered' do
      member1 = Member.first
      member2 = Member.last

      stub_request(:get, /.*/).to_timeout
      Tokyorails::MeetupTasks.import_members
      member1.should == Member.first
      member2.should == Member.last
    end

  end

  context '.import_events' do
    before(:each) do
      WebMock.reset!
      WebMock.disable_net_connect!
      stub_request(:get, /.*events.json/).to_return(:body => get_response('events.json'))
      stub_request(:get, /.*.jpeg/).to_return(:body => File.new(Rails.root.join('spec','fixtures','example.jpg')), :status => 200)
      stub_request(:get, /.*rsvps.json/).to_return(:body => get_response('rsvps_59784102.json'))
      stub_request(:get, /.*photos.json/).to_return(:body => get_response('photos_for_event.json'))
      Tokyorails::MeetupTasks.import_events
      WebMock.reset!
    end

    it 'should create new events' do
      Event.count.should == 9
    end

    it 'should do nothing if api is not available' do
      event1 = Event.first
      event2 = Event.last
      stub_request(:get, /.*/).to_timeout
      Tokyorails::MeetupTasks.import_events
      event1.should == Event.first
      event2.should == Event.last
    end

    it 'should also create images for each event' do
      Image.count.should == 18
    end

    it 'should not result in more images if nothing has changed' do
      lambda do
        stub_request(:get, /.*events.json/).to_return(:body => get_response('events.json'))
        stub_request(:get, /.*.jpeg/).to_return(:body => File.new(Rails.root.join('spec','fixtures','example.jpg')), :status => 200)
        stub_request(:get, /.*photos.json/).to_return(:body => get_response('photos_for_event.json'))
        Tokyorails::MeetupTasks.import_events
      end.should_not change(Image, :count)
    end

    it 'should decrease the image count if the new response no longer has those URLs' do
      stub_request(:get, /.*events.json/).to_return(:body => get_response('events.json'))
      stub_request(:get, /.*.jpeg/).to_return(:body => File.new(Rails.root.join('spec','fixtures','example.jpg')), :status => 200)
      stub_request(:get, /.*photos.json/).to_return(:body => get_response('photos_for_event_less.json'))
      Tokyorails::MeetupTasks.import_events
      Image.count.should == 9
    end

    it 'should increase the image count if the new response new URLs' do
      stub_request(:get, /.*events.json/).to_return(:body => get_response('events.json'))
      stub_request(:get, /.*.jpeg/).to_return(:body => File.new(Rails.root.join('spec','fixtures','example.jpg')), :status => 200)
      stub_request(:get, /.*photos.json/).to_return(:body => get_response('photos_for_event_more.json'))
      Tokyorails::MeetupTasks.import_events
      Image.count.should == 27
    end

  end

  context '.import_rsvps' do
    before(:each) do
      WebMock.reset!
      WebMock.disable_net_connect!
      stub_request(:get, /.*/).to_return(:body => get_response('rsvps_59784102.json'))
      Tokyorails::MeetupTasks.import_rsvps_for_event(59784102)
      WebMock.reset!
    end

    it 'should create rsvps for the supplied event uid' do
      Rsvp.count.should == 32
      Rsvp.attending.count.should == 27
      Rsvp.not_attending.count.should == 4
      Rsvp.waiting.count.should == 1
    end

    it 'should update existing RSVPs when the status changes' do
      stub_request(:get, /.*/).to_return(:body => get_response('rsvps_59784102_changes.json'))
      Tokyorails::MeetupTasks.import_rsvps_for_event(59784102)
      Rsvp.count.should == 32
      Rsvp.attending.count.should == 27
      Rsvp.not_attending.count.should == 5
      Rsvp.waiting.count.should == 0
    end
  end

  context 'API paging and offsets' do

    before(:each) do
      WebMock.reset!
      WebMock.disable_net_connect!
    end

    it 'should import using paging if there are more members than the page size' do
      stub_request(:get, /.*/).
        to_return(:body => get_response('members_offset_0.json')).then.
        to_return(:body => get_response('members_offset_1.json')).then.
        to_raise("Unnecessary calls made")
      Tokyorails::MeetupTasks.import_members
      Member.count.should == 214
    end
  end
end
