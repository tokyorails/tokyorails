# -*- encoding : utf-8 -*-
require 'spec_helper'

class DummyMember
  include Tokyorails::GithubMethods
end

describe Tokyorails::GithubMethods do

  use_vcr_cassette

  before(:each) do
    @dm = DummyMember.new
  end

  context 'listing github projects' do
    it 'should return a list of repositories belonging to a member' do
      @dm.class_eval do
        def github_username
          'rurounijones'
        end
      end

      @dm.github_projects.size.should > 0
      @dm.github_projects.first['ssh_url'].include?('rurounijones').should be_true
    end

    it 'should return an empty array if the member does not have a github username' do
      @dm.class_eval do
        def github_username
          nil
        end
      end

      @dm.github_projects.should == []
    end

    it 'should return an empty array if an exception is raised' do
      @dm.class_eval do
        def github_username
          'rurounijones'
        end
      end

      stub_request(:get, /.*github.*/).to_timeout

      @dm.github_projects.should == []
    end

    it 'should return an empty array if the github username could not be found' do
      @dm.class_eval do
        def github_username
          'thisisauserthatdoesnotexistongithubiamsure'
        end
      end

      @dm.github_projects.should == []
    end

  end


end
