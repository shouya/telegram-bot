require_relative 'objects'

class TelegramBot::Contact <
      Struct.new(:id,
                 :phone_number,
                 :first_name,
                 :last_name)
  include TelegramBot::AutoFromMethods

  def self.hash_key_aliases
    {
      :id => :user_id
    }
  end
end
