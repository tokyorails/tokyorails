# -*- encoding : utf-8 -*-
class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end
end
