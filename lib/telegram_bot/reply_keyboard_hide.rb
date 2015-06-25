class TelegramBot::ReplyKeyboardHide <
      Struct.new(:hide_keyboard,
                 :selective)
  include AutoFromMethods
end
