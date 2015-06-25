class TelegramBot::PhotoSize <
      Struct.new(:id, :width, :height, :file_size)
  include AutoFromMethods

  def hash_key_aliases
    {
      :id => :file_id
    }
  end
end
