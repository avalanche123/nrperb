require 'zlib'

module NRPE
  class Packet < Struct.new(:packet_version, :packet_type, :crc32, :result_code, :buffer, :random)
    NRPE_PACKET_VERSION_3 = 3
    NRPE_PACKET_VERSION_2 = 2
    NRPE_PACKET_VERSION_1 = 1

    QUERY_PACKET = 1
    RESPONSE_PACKET = 2

    MAX_PACKETBUFFER_LENGTH = 1024

    MAX_PACKET_SIZE = 12 + 1024

    def initialize(*args)
      if args.length == 1
        super(*args.first.unpack("nnNnA#{MAX_PACKETBUFFER_LENGTH}n"))
      else
        super
      end
    end

    def packet_version
      super || NRPE_PACKET_VERSION_2
    end

    def packet_type=(type)
      raise "Invalid packet type" unless [QUERY_PACKET, RESPONSE_PACKET].include?(type)
      super
    end

    def result_code
      super || 0
    end

    def random
      super || 1
    end

    def to_s
      [packet_version, packet_type, crc32, result_code, buffer, random].pack("nnNna#{MAX_PACKETBUFFER_LENGTH}n")
    end

    def crc32
      crc32 = calculate_crc32 unless crc32
    end

    def validate_crc32
      raise 'Invalid CRC32' unless crc32 == calculate_crc32
    end

    private

    def calculate_crc32
      Zlib::crc32([packet_version, packet_type, 0, result_code, buffer, random].pack("nnNna#{MAX_PACKETBUFFER_LENGTH}n"))
    end
  end
end
