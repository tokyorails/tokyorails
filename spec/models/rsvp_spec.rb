require 'spec_helper'

describe '.member' do
  it "finds the member from the rsvp" do
    member = Factory(:member)
    rsvp = Factory(:rsvp, :member_id => member.uid)
    rsvp.member.should == member
  end
end
