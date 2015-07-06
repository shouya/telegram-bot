require 'forwardable'
require_relative 'shorthand_methods'

class TelegramBot
  class MessageProxy
    extend Forwardable

    attr_accessor :bot, :message, :matcher

    def initialize(bot, message, matcher)
      @bot = bot
      @message = message
      @matcher = matcher
    end

    include TelegramBot::ShorthandMethods
  end
end
