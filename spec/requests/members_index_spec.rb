require 'spec_helper'

feature "Viewing users" do

  scenario "A list of registered users" do
    visit members_path
    page.should have_content('Current Members')
  end

end
