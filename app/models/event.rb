class Event < ActiveRecord::Base
  include Tokyorails::GithubMethods

  has_many :images, :as => :imageable, :dependent => :destroy

  has_many :event_translations
  accepts_nested_attributes_for :event_translations, :allow_destroy => true

  scope :upcoming, where(:status => 'upcoming')
  scope :past, where(:status => 'past')
  scope :recent, order('time DESC')

  validates_presence_of :uid, :name
  validates_uniqueness_of :uid

  translates :html, :fallbacks_for_empty_translations => true

  def event_url
    "http://meetup.com/tokyo-rails/events/#{uid}"
  end
end
