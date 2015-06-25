require_relative 'objects'

class TelegramBot::GroupChat < Struct.new(:id, :title)
  include TelegramBot::AutoFromMethods
end
