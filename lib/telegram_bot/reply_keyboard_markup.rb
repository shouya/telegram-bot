class TelegramBot::ReplyKeyboardMarkup <
      Struct.new(:keyboard,
                 :resize_keyboard,
                 :one_time_keyboard,
                 :selective)
  include TelegramBot::AutoFromMethods
end
