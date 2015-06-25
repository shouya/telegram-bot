require_relative 'objects'

class TelegramBot::Update < Struct.new(:id, :message)
  include TelegramBot::AutoFromMethods

  def self.extra_types
    {
      message: TelegramBot::Message
    }
  end

  def self.hash_key_aliases
    {
      id: :update_id
    }
  end

end
