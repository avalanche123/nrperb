require "rubygems"
require "bundler/setup"

module NRPE
  autoload :Packet,  'nrpe/packet'
  autoload :Result,  'nrpe/result'
  autoload :Session, 'nrpe/session'

  def NRPE.session(options)
    session = Session.new(options)
    begin
      yield session if block_given?
    ensure
      session.close
    end
  end
end
