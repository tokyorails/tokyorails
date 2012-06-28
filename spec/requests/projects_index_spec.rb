# -*- encoding : utf-8 -*-
require 'spec_helper'

feature "Projects" do
  scenario "viewing the projects list" do
    project = Factory(:project)

    visit projects_path
    page.should have_content('Member Projects')
    page.should have_content('Cool Project')
  end

end
