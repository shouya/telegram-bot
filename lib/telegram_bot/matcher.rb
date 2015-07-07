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

    def initialize(command = nil, no_split: false)
      @command = command
      @no_split = no_split
    end

    def ===(msg)
      start_with = '/'
      if !@command.nil?
        start_with += @command.to_s
      end
      return false if msg.type != :text
      return false if !msg.text.start_with? start_with

      true
    end

    def arguments(msg)
      case
      when @no_split
        cmd, _, args = msg.text.parition(/\s/)
        [cmd[1..-1], args]
      when @comamnd.nil?
        cmd, *args = msg.text.split
        [cmd[1..-1], *args]
      else
        cmd, *args = msg.text.split
        args
      end
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
