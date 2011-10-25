class MembersController < ApplicationController
  def index
    @members = Member.all(:params => { :key => '3bd2f1d651731357131488436e4e2', :page => 100, :group_id => '2270561' })
  end
end
