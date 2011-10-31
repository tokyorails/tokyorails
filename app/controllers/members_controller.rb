class MembersController < ApplicationController
  def index
    @members = Member.all(:params => { :key => Rails.application.config.meetup_com_api_key, :page => 100, :group_id => '2270561' })
    rescue ActiveResource::TimeoutError, ActiveResource::BadRequest => e
      @members = []
  end
end
