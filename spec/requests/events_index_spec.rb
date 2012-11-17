# -*- encoding : utf-8 -*-
require 'spec_helper'

feature "Viewing events" do
  scenario "A list of events" do
    next_event = create(:event, :status => 'upcoming')
    previous_event = create(:event, :status => 'past')

    visit events_path
    within('.hero-unit') do
      page.should have_content(next_event.name)
      page.should_not have_content(previous_event.name)
    end
    page.should have_content(previous_event.name)
  end

  scenario 'No future events scheduled' do
    visit events_path
    page.should have_content('The next meetup is not yet scheduled, but please register to get notified.')
  end

end
