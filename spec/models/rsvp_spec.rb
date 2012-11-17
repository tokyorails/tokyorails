require 'spec_helper'

describe '.member' do
  it "finds the member from the rsvp" do
    member = create(:member)
    rsvp = create(:rsvp, :member_id => member.uid)
    rsvp.member.should == member
  end
end
