require 'spec_helper'

describe Project do
  describe '#members' do
    let(:project) { create(:project) }
    let(:member_1) { create(:member) }
    let(:member_2) { create(:member) }
    let(:member_3) { create(:member) }

    it "returns associated members in the order they were added" do
      project.members << member_1
      project.members << member_2
      project.members << member_3
      project.reload
      project.members.should == [member_1, member_2, member_3]
    end

    it "excludes members who left the project" do
      project.members << member_1
      project.members << member_2
      project.reload
      project.members.should == [member_1, member_2]
      member_2.memberships.first.retire
      project.reload
      project.members.should == [member_1]
    end
  end

  describe '#alumni' do
    let(:project) { create(:project) }
    let(:member_1) { create(:member) }
    let(:member_2) { create(:member) }
    let(:member_3) { create(:member) }

    it "returns former members (alimni) in reverse date order that they retired" do
      project.members << member_1
      project.members << member_2
      project.members << member_3
      member_3.memberships.first.retire
      project.reload
      project.alumni.should == [member_3]
    end
  end

  describe ".leader?" do
    let(:project) { create(:project) }
    let(:member) { create(:member) }

    it "returns true if the passed in member is a lead on the project" do
      Membership.create(project_id: project.id, member_id: member.id, leader: true)
      project.leader?(member).should be_true
    end

    it "returns false if the passed in member is not a lead on the project" do
      Membership.create(project_id: project.id, member_id: member.id, leader: false)
      project.leader?(member).should be_false
    end
  end
end

