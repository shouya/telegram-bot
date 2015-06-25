require_relative 'objects'

class TelegramBot::Document <
      Struct.new(:id, :thumb, :file_name, :meme_type, :file_size)
  include TelegramBot::AutoFromMethods

  def self.hash_key_aliases
    {
      :id => :file_id
    }
  end

  def self.extra_types
    {
      thumb: PhotoSize
    }
  end
end
