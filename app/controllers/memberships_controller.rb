class MembershipsController < ApplicationController
  before_filter :require_login, :only => [:create, :destroy]

  def create
    @membership = current_user.memberships.find_or_initialize_by_project_id(params[:membership])
    @membership.deleted_at = nil
    @membership.save
    redirect_to projects_path
  end

  def destroy
    @membership = current_user.memberships.find(params[:id])
    @membership.retire
    redirect_to projects_path
  end
end
