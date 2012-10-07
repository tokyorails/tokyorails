# -*- encoding : utf-8 -*-
class MembersController < ApplicationController

  def index
    page_num = params[:page] || 1
    @members = Member.page(page_num).per(28)

    if params.has_key?(:query)
      @members = @members.name_like(params[:query])
    end
  end

  def show
    @member = Member.find(params[:id])
    github_repos = view_context.projects(@member)
    @repos = github_repos.select{|h| h["fork"] == false}
    @forks = github_repos.select{|h| h["fork"] == true}
    @project = Membership.active.where(member_id: @member).first.try(:project)
  end
end
