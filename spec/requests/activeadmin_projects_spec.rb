# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "AdminAdmin Projects" do

  context "as logged in admin" do
    before(:each) do
      @admin = create(:admin_user)
      visit new_admin_user_session_path
      fill_in 'admin_user[email]',    :with => @admin.email
      fill_in 'admin_user[password]', :with => "password"
      click_button('Login')
      page.should have_content('Signed in successfully.')

      visit new_admin_project_path
      fill_in 'project[github_url]', :with => 'http://github.com/sample_guy/sample_project'
      fill_in 'project[photo_url]', :with => 'http://www.tokyorails.org/assets/tokyo-rails-400x193.png'
      fill_in 'project[project_translations_attributes][0][title]', :with => "English Title"
      fill_in 'project[project_translations_attributes][0][description]', :with => "Sample description"
      fill_in 'project[project_translations_attributes][1][title]', :with => "日本語タイトル"
      fill_in 'project[project_translations_attributes][1][description]', :with => "日本語 description"
      click_button('Create Project')
    end

    describe "create a new project" do
      it "should work, creating 1 project and 2 ProjectTranslations" do
        Project.count.should eq(1)
        ProjectTranslation.count.should eq(2)
      end

      it "should be properly localised objects and pages in English" do
        project = Project.first
        I18n.locale = :en

        project.title.should eq("English Title")
        project.description.should eq("Sample description")

        visit projects_path(:locale => :en)
        page.should have_content("English Title")
        page.should have_content("Sample description")
      end

      it "should be properly localised objects and pages in Japanese" do
        project = Project.first
        I18n.locale = :ja

        project.title.should eq("日本語タイトル")
        project.description.should eq("日本語 description")

        visit projects_path(:locale => :ja)
        page.should have_content("日本語タイトル")
        page.should have_content("日本語 description")
      end
    end

    describe "editing an existing project" do

      before(:each) do
        project = Project.first
        visit edit_admin_project_path(project.id)
        fill_in 'project[project_translations_attributes][0][title]', :with => "English Title Edited"
        fill_in 'project[project_translations_attributes][0][description]', :with => "Sample description Edited"
        fill_in 'project[project_translations_attributes][1][title]', :with => "日本語タイトル Edited"
        fill_in 'project[project_translations_attributes][1][description]', :with => "日本語 description Edited"
        click_button('Update Project')
      end

      it "should work without creating new Projects and new ProjectTranslations" do
        Project.count.should eq(1)
        ProjectTranslation.count.should eq(2)
      end

      it "should be properly edited and localised in English" do
        project = Project.first
        I18n.locale = :en

        project.title.should eq("English Title Edited")
        project.description.should eq("Sample description Edited")

        visit projects_path(:locale => :en)
        page.should have_content("English Title Edited")
        page.should have_content("Sample description Edited")
      end

      it "should be properly edited localised in Japanese" do
        project = Project.first
        I18n.locale = :ja

        project.title.should eq("日本語タイトル Edited")
        project.description.should eq("日本語 description Edited")

        visit projects_path(:locale => :ja)
        page.should have_content("日本語タイトル Edited")
        page.should have_content("日本語 description Edited")
      end

      it "should have proper fallback to English when there is no Japanese version" do
        project = Project.first

        visit edit_admin_project_path(project.id)
        fill_in 'project[project_translations_attributes][1][title]', :with => ""
        click_button('Update Project')

        I18n.locale = :ja

        project.title.should eq("English Title Edited")

        visit projects_path(:locale => :ja)
        page.should have_content("English Title Edited")
      end
    end
  end
end


