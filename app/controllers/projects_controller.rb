# -*- encoding : utf-8 -*-
class ProjectsController < ApplicationController
  def index
    @projects = Project.all.map{|p| p.active? ? p : nil}.compact
    @icebox = Project.all.map{|p| p.active? ? nil : p}.compact
    @event = Event.upcoming.last
  end
end
