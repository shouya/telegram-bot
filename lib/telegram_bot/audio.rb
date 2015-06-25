require_relative 'objects'

class TelegramBot::Audio <
      Struct.new(:id, :duration, :mime_type, :file_size)
  include TelegramBot::AutoFromMethods

  def self.hash_key_aliases
    {
      :id => :file_id
    }
  end
end
