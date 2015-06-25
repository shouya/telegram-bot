require 'telegram_bot/version'
require 'telegram_bot/objects'
require 'telegram_bot/handler'
require 'telegram_bot/request'
require 'telegram_bot/request_methods'
require 'telegram_bot/poll_listener'

class TelegramBot
  include TelegramBot::EventHandler
  include TelegramBot::Request
  include TelegramBot::RequestMethods

  attr_accessor :token, :handlers, :history

  def initialize(history: 50, token:)
    @token = token
    @handlers = []
    @history = []
    @history_length = 50
  end

  def listen(method: :poll, interval: 5, path: '/hook')
    @listen = {
      method:   method,
      interval: interval,
      path:     path
    }
  end

  def extend_env(env)
    telegram_bot = self
    env.extend do
      define_method :bot do
        telegram_bot
      end
      alias_method :client, :bot

      define_method :history do
        telegram_bot.history
      end
    end
  end

  def append_history(message)
    @history << message
    @history = @history.last(@history_length || 0)
  end

  def start!
    case @listen[:method]
    when :poll
      PollListener.new(self, @listen[:interval])
    when :webhook
      warn 'not implemented'
    end
  end
end
