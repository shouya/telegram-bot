class TelegramBot::ForceReply <
      Struct.new(:force_reply,
                 :selective)
  include AutoFromMethods
end
