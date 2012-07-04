class Spike < ActiveRecord::Base
  validates_presence_of :description, :name
  attr_accessible :description, :name
  default_scope order('id ASC')
end
