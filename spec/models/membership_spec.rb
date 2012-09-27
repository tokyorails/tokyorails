require 'spec_helper'

describe Membership do
  describe '#active' do
    let(:member)        { Factory(:member) }
    let(:project)       { Factory(:project) }
    let(:old_project)   { Factory(:project) }
    let!(:membership)   { member.memberships.create!(:project_id => project.id) }
    let!(:membership_2) { member.memberships.create!(:project_id => old_project.id) }

    it "returns active memberships and excludes those that are retired" do
      membership_2.retire
      Membership.active.should == [membership]
    end
  end

  describe '.retire' do
    let(:project) { Factory(:project) }
    let(:member) { Factory(:member) }

    it "marks a membership as with deleted at" do
      project.members << member
      membership = member.memberships.first
      membership.deleted_at.should == nil
      membership.retire
      membership.deleted_at.should_not == nil
    end
  end
end


