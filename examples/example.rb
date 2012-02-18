require "rubygems"
require "bundler/setup"
require 'nrpe'

NRPE.session :host => 'boxconfig.dev.twilio.com', :port => 5666 do |session|
  result = session.execute('check_load')
  puts result.ok?
  puts result.warning?
  puts result.critical?
  puts result.text
end
