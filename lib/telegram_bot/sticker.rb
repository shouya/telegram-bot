class TelegramBot::Sticker <
      Struct(:id, :width, :height, :thumb, :file_size)

  include AutoFromMethods

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
