class TelegramBot::Update < Strict(:id, :message)
  include AutoFromMethods

  def self.extra_types
    {
      message: Message
    }
  end

  def self.hash_key_aliases
    {
      id: :update_id
    }
  end

end
