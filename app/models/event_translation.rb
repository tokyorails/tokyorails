class EventTranslation < ActiveRecord::Base
  belongs_to :event
  validates_uniqueness_of :locale, :scope => :event_id
end