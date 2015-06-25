require_relative 'objects'

class TelegramBot::Chat < Struct.new(:id)
  include TelegramBot::AutoFromMethods

  def self.from(id)
    case id
    when Integer
      TelegramBot::Chat.new(id)
    when TelegramBot::GroupChat, TelegramBot::User
      id
    when Hash
      if id.has_key? 'title'
        TelegramBot::GroupChat.from(id)
      elsif id.has_key? 'first_name'
        TelegramBot::User.from(id)
      else
        TelegramBot::Chat.from(id['id'])
      end
    else
      super
    end
  end
end
