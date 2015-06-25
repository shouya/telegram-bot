require_relative 'objects'

class TelegramBot::User <
      Struct.new(:id, :first_name, :last_name, :username)
  include TelegramBot::AutoFromMethods
end
