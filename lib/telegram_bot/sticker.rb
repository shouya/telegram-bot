require_relative 'objects'

class TelegramBot::Sticker <
      Struct.new(:id, :width, :height, :thumb, :file_size)

  include TelegramBot::AutoFromMethods

  def self.hash_key_aliases
    {
      :id => :file_id
    }
  end

  def self.extra_types
    {
      thumb: TelegramBot::PhotoSize
    }
  end
end
