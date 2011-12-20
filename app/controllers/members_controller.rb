class MembersController < ApplicationController
  def index
    @members = Member.all
  end
  
  def show
    @member = Member.find(params[:id])
  end
end
