require 'telegram_bot/version'
require 'telegram_bot/objects'
require 'telegram_bot/handler'

class TelegramBot
  include TelegramBot::EventHandler

  def initialize(token:)
    @token = token
    @handlers = []
  end

  def listen(method: :poll, interval: 5, path: '/hook')
    @listen = {
      method:   method,
      interval: interval,
      path:     path
    }
  end
end
