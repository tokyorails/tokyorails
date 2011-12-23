# -*- encoding : utf-8 -*-
require 'logglier'
if Rails.env.production?
  log = Logglier.new("https://logs.loggly.com/inputs/13a4323d-393d-4ebe-897c-3c4d3b481df8")
  log.info("If we knew what we were doing, it wouldn't be called research, would it?")
end
