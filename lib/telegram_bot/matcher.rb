class TelegramBot
  class Matcher
    def env(msg)
      msg.extend(BasicObject.new)
    end

    def ===(_)
      false
    end

    def arguments(msg)
      []
    end

    def extend_env(obj, msg)
      obj
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

    def extend_env(obj, msg)
      obj = super

      if Regexp === @pattern
        md = @pattern.match(msg.text)
        obj.extend do
          md.names.each do |grp|
            value = md[grp]
            define_method grp { value }
          end
        end
      end

      obj
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
