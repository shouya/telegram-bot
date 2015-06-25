require_relative 'objects'

class TelegramBot::Location < Struct.new(:longitude, :latitude)
  include TelegramBot::AutoFromMethods

  def self.from(hsh, lat = nil)
    case hsh
    when Integer
      new(hsh, lat)
    else
      super(hsh)
    end
  end
end
