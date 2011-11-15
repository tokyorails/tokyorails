class Event < ActiveResource::Base
  self.site = "https://api.meetup.com"
  self.prefix = "/2/"
  self.timeout = 5

  def shortened_date
    event_date = Time.at(self.time/1000)
    event_date.strftime("%d %b %y")
  end

 
  def self.upcoming
    all(:params => {:key => Rails.application.config.meetup_com_api_key, 
                          :status => "upcoming", :group_id => '2270561',
                          :page => 100})  
    rescue ActiveResource::TimeoutError, ActiveResource::BadRequest => e
      return []                              
  end

  def self.past
    all(:params => {:key => Rails.application.config.meetup_com_api_key, 
                          :status => "past", :group_id => '2270561', 
                          :page => 100})
    rescue ActiveResource::TimeoutError, ActiveResource::BadRequest => e
      return []                              
  end
end
