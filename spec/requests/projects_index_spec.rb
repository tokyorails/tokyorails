# -*- encoding : utf-8 -*-
require 'spec_helper'

feature "Projects" do
  scenario "viewing the projects list" do
    project = Factory(:project)

    visit projects_path
    page.should have_content('Member Projects')
    page.should have_content('Cool Project')
  end

  scenario "joining a project" do
    pending
    project = Factory(:project)
    member = Factory(:member)
    login(member)

    project.members.should == []
    visit projects_path

    click_link 'Join Project'
    project.members.should == [member]

  end
end
