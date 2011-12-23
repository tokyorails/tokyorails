# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Photo do
  context "given there are photos on meetup.com" do

    before(:each) do
      WebMock.allow_net_connect!
    end

    describe ".all" do
      it "returns a list of all photos" do
        photo_albums = Photo.all(:params => { :key => Rails.application.config.meetup_com_api_key, :page => 100, :group_id => '2270561' })
        photo_albums.size.should > 4
      end
    end
  end
end
