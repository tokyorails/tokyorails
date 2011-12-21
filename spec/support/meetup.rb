# Return a regex'd URL for meetup events
#
# Return a regex of a URL which will match requests for past and upcoming meetup
# events.
#
# This method is used during testing by tests that access the meetup event api
#
# @param [String] period The period we want to see. Either 'upcoming' or 'past'
# @return [Regexp] A regexp for matching against the meetup event url
def api_url(period)
  %r{https://api.meetup.com/2/events.*status=#{period}}
end