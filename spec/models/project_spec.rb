require 'spec_helper'

describe Project do
  describe '#members' do
    let(:project) { Factory(:project) }
    let(:member_1) { Factory(:member) }
    let(:member_2) { Factory(:member) }
    let(:member_3) { Factory(:member) }

    it "returns associated members in the order they were added" do
      project.members << member_1
      project.members << member_2
      project.members << member_3
      project.reload
      project.members.should == [member_1, member_2, member_3]
    end
  end
end

