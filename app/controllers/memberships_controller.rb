class MembershipsController < ApplicationController
  before_filter :require_login, :only => [:create, :destroy]

  def create
    @membership = current_user.memberships.create(params[:membership])
    redirect_to projects_path
  end

  def destroy
    @membership = current_user.memberships.find(params[:id])
    @membership.destroy
    redirect_to projects_path
  end
end
