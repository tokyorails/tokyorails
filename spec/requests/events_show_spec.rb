# -*- encoding : utf-8 -*-
require 'spec_helper'

feature "Show a event" do
  scenario "Renders the details of an event" do
    @event = Factory(:event, :status => 'past')
    
    visit event_path(:id => @event.id)
    page.should have_content("#{@event.name}")
    page.should have_content("Please RSVP for this event")
    page.should have_content("Additional HTML")
  end

end
