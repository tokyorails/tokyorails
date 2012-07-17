require 'spec_helper'

describe ApplicationHelper do
  describe '#icon' do
    it "generates html for a twitter bootstrap icon" do
      icon(:user).should == "<i class='icon-user'></i> "
      icon(:user, :white).should == "<i class='icon-user icon-white'></i> "
    end
  end
end
