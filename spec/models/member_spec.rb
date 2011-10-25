require 'spec_helper'

describe Member do
  context "given there are members on meetup.com" do

    WebMock.allow_net_connect!
    describe ".all" do
      it "returns a list of all current members" do
        members = Member.all(:params => { :key => '3bd2f1d651731357131488436e4e2', :page => 100, :group_id => '2270561' })
        members.size.should > 50
      end
    end
  end
end
