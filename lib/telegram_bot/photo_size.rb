require_relative 'objects'

class TelegramBot::PhotoSize <
      Struct.new(:id, :width, :height, :file_size)
  include TelegramBot::AutoFromMethods

  def hash_key_aliases
    {
      :id => :file_id
    }
  end
end
