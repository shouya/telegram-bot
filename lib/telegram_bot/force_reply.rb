require_relative 'objects'

class TelegramBot::ForceReply <
      Struct.new(:force_reply,
                 :selective)
  include TelegramBot::AutoFromMethods
end
