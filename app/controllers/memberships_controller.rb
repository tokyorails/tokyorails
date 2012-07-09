class MembershipsController < ApplicationController
  before_filter :require_login, :only => [:create, :destroy]

  def create
    @membership = current_user.toggle_membership(params[:membership][:project_id])
    @membership.save
    redirect_to projects_path
  end

  def destroy
    @membership = current_user.toggle_membership(params[:membership][:project_id])
    @membership.save
    redirect_to projects_path
  end
end
