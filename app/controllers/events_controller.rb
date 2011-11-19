class EventsController < ApplicationController
  def index
    @past_events = Event.past.reverse
    @upcoming_events = Event.upcoming
  end
end
