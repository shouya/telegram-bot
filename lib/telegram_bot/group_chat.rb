require_relative 'objects'

class GroupChat < Struct.new(:id, :title)
  include TelegramBot::AutoFromMethods
end
