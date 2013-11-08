require 'socket'
require 'openssl'
require 'timeout'

module NRPE
  class Session
    def initialize(options)
      process_options!(options)
    end

    def close
      socket.close if @socket
    end

    def execute(check, params = nil)
      if params.nil? or params.count == 0
        arguments = ""
      else
        arguments = params.join("!").prepend("!")
      end

      send_query("#{check}#{arguments}")
      response = read_response

      Result.new(response.result_code, response.buffer)
    end

    private

    def send_query(check)
      packet = Packet.new.tap do |p|
        p.packet_type = Packet::QUERY_PACKET
        p.buffer = check
      end
      socket.write(packet.to_s)
    end

    def read_response
      response = Packet.new(socket.read(Packet::MAX_PACKET_SIZE))
      response.validate_crc32
      response
    end

    def process_options!(options)
      raise ArgumentError, "host is a required option" if options[:host].nil?
      options[:port]    ||= 5666
      options[:timeout] ||= 10
      options[:use_ssl] ||= true
      @options = options
    end

    def socket
      @socket ||= begin
        optval = [Integer(@options[:timeout]), 0].pack("l_2")

        socket = timeout(@options[:timeout]) do
          TCPSocket.open(@options[:host], @options[:port])
        end

        socket.setsockopt(:SOCKET, :RCVTIMEO, optval)
        socket.setsockopt(:SOCKET, :SNDTIMEO, optval)

        if @options[:use_ssl]
          ssl_context = OpenSSL::SSL::SSLContext.new "SSLv23_client"
          ssl_context.ciphers = 'ADH'
          socket = OpenSSL::SSL::SSLSocket.new(socket, ssl_context)
          socket.sync_close = true
          socket.connect
        end

        ObjectSpace.define_finalizer(self, proc {|id| socket.close})

        socket
      end
    end
  end
end
