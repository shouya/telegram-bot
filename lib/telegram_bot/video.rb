require_relative 'objects'

class TelegramBot::Video <
      Struct.new(:id,
                 :width,
                 :height,
                 :duration,
                 :thumb,
                 :mime_type,
                 :file_size,
                 :caption)

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
