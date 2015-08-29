module TelegramBot::ShorthandMethods
  def send_message(text, *args, to: message.chat, **opts)
    bot.send_message(to, text, *args, **opts)
  end

  alias_method :say, :send_message

  def reply(text, *args, to: message.chat, **opts)
    bot.send_message(to, text, *args, reply_to: message, **opts)
  end

  def forward_message(to)
    bot.forward_message(message, to)
  end

  alias_method :forward_to, :forward_message

  def send_chat_action(action)
    bot.send_chat_action(message.chat, action)
  end
end
