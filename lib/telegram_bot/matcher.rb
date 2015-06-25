module TelegramBot
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

    def call_block(msg, blk)
      env.instance_exec(*arguments(msg), &blk)
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

    def env(msg)
      obj = super

      if Regexp === @pattern
        md = @pattern.match(msg.text)
        obj.singleton_class.class_eval do
          md.names.each do |n|
            define_method n { md[n] }
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

  class FallbackMatcher < Matcher
    def ===(_)
      true
    end
  end
end
