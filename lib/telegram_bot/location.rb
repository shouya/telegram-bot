class TelegramBot::Location < Field.new(:longitude, :latitude)
  include AutoFromMethods

  def self.from(hsh, lat = nil)
    case hsh
    when Integer
      new(hsh, lat)
    else
      super
    end
  end
end
