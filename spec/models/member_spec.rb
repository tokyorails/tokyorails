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

end
