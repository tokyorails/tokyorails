class Photo < ActiveRecord::Base
  belongs_to :member

  delegate :thumb, :to => :file
  image_accessor :file
end
