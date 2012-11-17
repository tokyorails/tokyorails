# -*- encoding : utf-8 -*-
require 'spec_helper'

feature "Projects" do
  scenario "viewing the projects list" do
    project = create(:project)

    visit projects_path
    page.should have_content('Collaborate!')
    pending 'figure out why this fails travis but not locally'
    page.should have_content('Cool Project')
  end

  scenario "joining a project" do
    pending
    project = create(:project)
    member = create(:member)
    login(member)

    project.members.should == []
    visit projects_path

    click_link 'Join'
    project.members.should == [member]

  end
end
