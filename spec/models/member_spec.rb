# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Member do

  context "validations" do
    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:bio) }

    it { Factory(:member); should validate_uniqueness_of(:uid) }
    it { Factory(:member); should validate_uniqueness_of(:github_username) }
  end

  context "associations" do
    it { should have_one(:image) }
  end

  context "scopes" do
    it "should return users with names like given query" do
      member_a = Factory(:member, :name => "Adam Akhtar")
      member_b = Factory(:member, :name => "Adamski")
      member_c = Factory(:member, :name => "Miles Newton")
      Member.name_like("adam").size.should eq 2
      Member.name_like("adam").should include member_a
      Member.name_like("adam").should include member_b
      Member.name_like("adam").should_not include member_c
    end
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
      member = Factory(:member, :uid => "654321", :access_token => nil)
      authenticated_member = Member.authenticate({"uid" => "654321", "credentials" => { "token" => "ab555"}})
      member.reload
      member.access_token.should == "ab555"
    end

    it "does not authenticate if there is no matching existing user" do
      member = Factory(:member, :uid => "7531", :access_token => nil)
      authenticated_member = Member.authenticate({"uid" => "654321", "credentials" => { "token" => "ab555"}})
      member.reload
      member.access_token.should == nil
    end
  end

  describe '#toggle_membership' do
    let(:member)  { Factory(:member) }
    let(:project) { Factory(:project) }

    it "creates a membership to a project for the member if they were not previously joined" do
      member.memberships.should == []
      member.toggle_membership(project.id)
      member.memberships.count.should == 1
      member.memberships.last.project.should == project
    end

    it "removes an existing membership to a project for the member" do
      member.memberships.create!(:project_id => project)
      member.memberships.last.project.should == project
      member.toggle_membership(project.id)
      member.memberships.reload
      member.memberships.count.should == 0
      member.memberships.should == []
    end
  end

  describe '#member_of?' do
    let(:member)     { Factory(:member) }
    let(:project)    { Factory(:project) }
    let(:other_project)    { Factory(:project) }
    let!(:membership) { member.memberships.create!(:project_id => project) }
    it 'returns if a member has a membership to a specific project' do
      member.member_of?(project).should be_true
      member.member_of?(other_project).should_not be_true
    end
  end
end
