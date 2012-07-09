module UserMacros
  def login(member)
    OmniAuth.config.add_mock(:meetup, :uid => member.uid)
    visit '/auth/meetup'
  end
end
RSpec.configure { |config| config.include(UserMacros) }
