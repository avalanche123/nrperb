# NRPErb

Ruby interface to Nagios Remote Plugin Executor daemon.
Let's you run remote nagios checks from ruby

```ruby
require 'nrpe'

NRPE.session :host => '10.190.157.127', :port => 5666 do |session|
  result = session.execute('check_load')
  puts result.ok?
  puts result.warning?
  puts result.critical?
  puts result.text
end
```

## Install

* clone repository
* run `bundle install`
* run `bundle exec check_nrpe -h`
* ...
* profit
