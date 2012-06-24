# -*- encoding : utf-8 -*-
class Image < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true

  delegate :thumb, :to => :file
  image_accessor :file

  def self.event_photos(limit = 30)
    where("imageable_type = ?", "Event").order("id DESC").limit(limit)
  end
end
