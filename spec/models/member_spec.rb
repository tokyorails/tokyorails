# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Member do

  context "validations" do
    it { should validate_presence_of(:meetup_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:bio) }

    it { Factory(:member); should validate_uniqueness_of(:meetup_id) }
    it { Factory(:member); should validate_uniqueness_of(:github_username) }
  end

  context "associations" do
    it { should have_one(:image) }
  end

  context 'photo' do
    it 'should return an existing photo' do
      member = Factory(:member)
      member.photo.should == Image.first
    end

    it 'should create and return a new photo based on photo_url if present' do
      stub_request(:get, "localhost/photo.jpg").to_return(:body => File.new(Rails.root.join('spec','fixtures','example.jpg')), :status => 200)

      member = Factory(:member, :image => nil)
      member.photo.should == Image.first
    end

    it 'should return nil if there is no photo or photo_url' do
      member = Factory(:member, :photo_url => nil, :image => nil)
      member.photo.should == nil
    end
  end

  describe '#authenticate' do
    it "finds an existing member based on uid and saves the token" do
      member = Factory(:member, :meetup_id => "654321", :access_token => nil)
      authenticated_member = Member.authenticate({"uid" => "654321", "credentials" => { "token" => "ab555"}})
      member.reload
      member.access_token.should == "ab555"
    end

    it "does not authenticate if there is no matching existing user" do
      member = Factory(:member, :meetup_id => "7531", :access_token => nil)
      authenticated_member = Member.authenticate({"uid" => "654321", "credentials" => { "token" => "ab555"}})
      member.reload
      member.access_token.should == nil
    end
  end
end
