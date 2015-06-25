require 'ostruct'
require 'active_support/inflector'

require_relative 'matcher'

module TelegramBot
  module EventHandler
    class Handler < OpenStruct
      attr_accessor :type, :action, :pass

      def initialize(matcher, action, pass)
        @matcher = matcher
        @action  = action
        @pass    = pass
      end

      def pass?
        @pass
      end

      def call(msg)
        @matcher.call_block(msg, &@action) if @matcher === msg
      end
    end


    def self.included(clazz)
      clazz.send :prepend, Class.new do
        attr_accessor :handlers

        def initialize
          @handlers = []
        end
      end
    end

    def on(type, *args, pass: false, &block)
      matcher_class = "#{type}_matcher".classify
      matcher = matcher_class.new(*args)
      handler = Handler.new(matcher, block, pass)
      @handlers << handler
    end
  end
end
