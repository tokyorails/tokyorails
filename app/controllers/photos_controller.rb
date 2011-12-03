class PhotosController < ApplicationController
  def index
    @photo_albums = Photo.all(:params => { :key => Rails.application.config.meetup_com_api_key, :page => 100, :group_id => '2270561' }).select{|p| p.albumtitle!="Meetup Group Photo Album"}
    rescue ActiveResource::TimeoutError, ActiveResource::BadRequest => e
      @photo_albums = []
  end
end
