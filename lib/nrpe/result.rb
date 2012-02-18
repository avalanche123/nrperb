module NRPE
  class Result
    CODE_OK = 0
    CODE_WARNING = 1
    CODE_CRITICAL = 2

    attr_reader :code, :text

    def initialize(code, text)
      @code, @text = code, text
    end

    def ok?
      @code == CODE_OK
    end

    def warning?
      @code == CODE_WARNING
    end

    def critical?
      @code == CODE_CRITICAL
    end
  end
end
