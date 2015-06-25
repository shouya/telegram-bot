require 'ostruct'
require 'active_support/inflector'

require_relative 'matcher'
require_relative 'blank_slate'

class TelegramBot
  module EventHandler
    class Handler
      attr_accessor :type, :action, :pass

      def initialize(matcher, action, pass)
        @matcher = matcher
        @action  = action
        @pass    = pass
      end

      def pass?
        @pass
      end

      def ===(msg)
        @matcher === msg
      end

      def arguments(msg)
        @matcher.arguments(msg)
      end
    end

    module PrependMethods
      attr_accessor :handlers

      def initialize(*args, &block)
        @handlers = []
        super(*args, &block)
      end
    end

    def self.included(clazz)
      clazz.prepend PrependMethods
    end


    def on(type, *args, pass: false, &block)
      matcher_class_name = "telegram_bot/#{type}_matcher".classify
      matcher_class = matcher_class_name.constantize
      matcher = matcher_class.new(*args)
      handler = Handler.new(matcher, block, pass)
      @handlers << handler
    end

    def handle(msg)
      env = BlankSlate.new
      self.extend_env(env)
      msg.extend_env(env)

      @handlers.each do |hndlr|
        next unless hndlr === msg

        hndlr.matcher.extend_env(env, msg)

        env.extend do
          define_method :handler do
            hndlr
          end
        end

        env.call(handler.arguments(msg),
                 &handler.action)
      end
    end
  end
end
