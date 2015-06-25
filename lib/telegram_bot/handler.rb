require 'ostruct'

module TelegramBot::EventHandler
  class Handler < OpenStruct
    attr_accessor :type, :action

    def initialize(type, action, pass: false)
      @type    = type
      @pass    = pass
      @action  = action
    end

    def pass?
      @pass
    end

    def call(env)
      env.instance_exec(env.message, &action)
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

  def on_text(pattern, **opts, &block)
    handler = Handler.new(:text, block, **opts)
    handler.pattern = pattern
    @handlers << handler
  end

  def on_anything(&block)
    @handlers << Handler.new(:any, block, **opts)
  end
end
