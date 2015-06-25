require 'datetime'
require 'time'

class TelegramBot::Date < Struct.new()
  include AutoFromMethods

  def self.from(date)
    case date
    when ::DateTime, ::Date, ::Time
      new(date)
    when Integer
      new(Time.at(date).to_datetime)
    when String
      new(Datetime.parse(date))
    when TelegramBot::Date
      date
    else
      super
    end
  end


  attr_accessor :datetime

  def initialize(datetime)
    @self.datetime = datetime
  end

  def method_missing(sym, *args, &blk)
    @datetime.send(sym, *args, &blk)
  end
end
