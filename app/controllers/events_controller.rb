# -*- encoding : utf-8 -*-
class EventsController < ApplicationController
  def index
    @past_events = Event.past
    @upcoming_events = Event.upcoming
  end

  def show
    @event = Event.find(params[:id])
  end
end
