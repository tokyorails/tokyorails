# encoding: UTF-8
require 'spec_helper'

feature "Internationalization" do
  scenario "when I view the default url it should show the page in English" do
    visit root_url
    page.should have_content('The TOKYO Rails Meetup Group is for web engineers')
  end

  scenario "viewing the default url should have the 'english' tab selected" do
    visit root_url
    page.should_not have_css('li.active', :text => '日本語')
    page.should have_css('li.active', :text => 'English')
  end

  scenario "clicking the '日本語' tab should show the page in Japanese" do
    visit root_url
    click_link('日本語')
    page.should have_content('TOKYO Rails Meetupはルビーオンレイルズフレームワーク')
  end

  scenario "viewing a japanese path should have the '日本語' tab selected" do
    visit '/ja'
    page.should have_css('li.active', :text => '日本語')
    page.should_not have_css('li.active', :text => 'English')
  end
end
