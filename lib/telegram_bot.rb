require_relative 'telegram_bot/version'
require_relative 'telegram_bot/objects'
require_relative 'telegram_bot/handler'
require_relative 'telegram_bot/request'
require_relative 'telegram_bot/request_methods'
require_relative 'telegram_bot/poll_listener'
require_relative 'telegram_bot/shorthand_methods'


class TelegramBot
  include TelegramBot::EventHandler
  include TelegramBot::Request
  include TelegramBot::RequestMethods

  attr_accessor :history

  def initialize(history: 50)
    @history = []
    @history_length = 50
    @listener = nil
  end

  def listen(method: :poll, interval: 5, path: '/hook')
    case method
    when :poll
      @listener = PollListener.new(self, interval)
    when :webhook
      warn 'not implemented'
    end
  end

  def append_history(message)
    @history << message
    @history = @history.last(@history_length || 0)
  end

  def start!
    @listener.start!
  end

  def stop!
    @listener.stop!
  end
end
