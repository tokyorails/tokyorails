class Event < ActiveRecord::Base
  include Tokyorails::GithubMethods

  has_many :images, :as => :imageable, :dependent => :destroy

  scope :upcoming, where(:status => 'upcoming')
  scope :past, where(:status => 'past')
  scope :recent, order('time DESC')

  validates_presence_of :uid, :name
  validates_uniqueness_of :uid

  def event_url
    "http://meetup.com/tokyo-rails/events/#{uid}"
  end
end
