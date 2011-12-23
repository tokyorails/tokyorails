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
    
  end

end
