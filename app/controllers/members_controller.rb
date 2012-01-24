# -*- encoding : utf-8 -*-
class MembersController < ApplicationController
  def index
    @members = params[:query] ? Member.name_like(params[:query]) : Member.all
  end
  
  def show
    @member = Member.find(params[:id])
  end
end
