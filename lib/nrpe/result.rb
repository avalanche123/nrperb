module NRPE
  class Result < Struct.new(:code, :text)
    CODE_OK = 0
    CODE_WARNING = 1
    CODE_CRITICAL = 2

    def ok?
      code == CODE_OK
    end

    def warning?
      code == CODE_WARNING
    end

    def critical?
      code == CODE_CRITICAL
    end
  end
end
