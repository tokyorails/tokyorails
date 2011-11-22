VCR.config do |c|
  c.stub_with :webmock
  c.default_cassette_options = {:record => :new_episodes}
#  c.ignore_localhost = true
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end
