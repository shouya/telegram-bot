module TelegramBot::ShorthandMethods
  def send_message(text, *args, to: message.chat)
    bot.send_message(to, text, *args)
  end

  def reply(*args)
    send_message(*args, reply_to: message)
  end

  def forward_message(to)
    bot.forward_message(message, to)
  end

  def send_chat_action(action)
    bot.send_chat_action(message.chat)
  end
end
