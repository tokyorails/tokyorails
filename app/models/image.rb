# -*- encoding : utf-8 -*-
class Image < ActiveRecord::Base
  belongs_to :member

  delegate :thumb, :to => :file
  image_accessor :file
end
