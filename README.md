# NRPErb

Ruby interface to Nagios Remote Plugin Executor daemon.
Let's you run remote nagios checks from ruby

## Install

Either

* clone repository
* run `bundle install`
* run `bundle exec check_nrpe -h`

Or

* gem install nrperb
* check_nrpe -h

## Usage

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

You can pass arguments to the check, but your NRPE server must accept them

```ruby
require 'nrpe'

NRPE.session :host => '10.190.157.127', :port => 5666 do |session|
  result = session.execute('check_load', [90, 95])
  puts result.ok?
  puts result.warning?
  puts result.critical?
  puts result.text
end
```

### Options

```ruby
{
  :host => nil,    # ip address or hostname of target host, required, cannot be nil
  :port => 5666,   # port, remote nagios plugin executor daemon is listening on, defaults to 5666
  :timeout => 10,  # connection attempt timeout, defaults to 10
  :use_ssl => true # wether to use secure ssl connection (nagios defaults to true) or not, defaults to true
}
```

## Maintainer(s)

* Bulat Shakirzyanov <mallluhuct@gmail.com>

Cheers!