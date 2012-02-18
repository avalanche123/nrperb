lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'nrpe/version'

Gem::Specification.new do |s|
  s.name        = "nrperb"
  s.version     = NRPE::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Bulat Shakirzyanov"]
  s.email       = ["mallluhuct@gmail.com"]
  s.homepage    = "http://github.com/avalanche123/nrperb"
  s.summary     = "Execute nagios remote plugins from ruby"
  s.description = "NRPErb is a nagios remote plugin executor protocol implementation in Ruby, that lets you ruby remove nagios checks from your ruby scripts"

  s.required_rubygems_version = ">= 1.3.6"

  s.files        = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md)
  s.executables  = ['check_nrpe']
  s.require_path = 'lib'
end
