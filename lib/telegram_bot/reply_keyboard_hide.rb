class TelegramBot::ReplyKeyboardHide <
      Struct.new(:hide_keyboard,
                 :selective)
  include TelegramBot::AutoFromMethods
end
