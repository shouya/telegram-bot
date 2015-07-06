class TelegramBot
  class Matcher
    def ===(_)
      false
    end

    def arguments(msg)
      []
    end
  end

  class TextMatcher < Matcher
    attr_accessor :pattern

    def initialize(pat = nil)
      @pattern = pat
    end

    def ===(msg)
      return false unless msg.type == :text
      return true  if @pattern.nil?
      @pattern === msg.text
    end

    def arguments(msg)
      if Regexp === @pattern
        md = @pattern.match(msg.text)
        md.to_a
      else
        [msg.text]
      end
    end
  end

  class CommandMatcher < Matcher
    attr_accessor :command

    def initialize(command)
      @command = command
    end

    def ===(msg)
      msg.type == :text and msg.text.start_with?("/#{@command}")
    end

    def arguments(msg)
      msg.text.split[1..-1]
    end
  end

  class AnythingMatcher < Matcher
    def ===(_)
      true
    end
  end

  class FallbackMatcher < AnythingMatcher
  end

end
