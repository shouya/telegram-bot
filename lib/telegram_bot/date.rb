require_relative 'objects'
require 'time'

class TelegramBot::Date
  include TelegramBot::AutoFromMethods

  def self.members
    []
  end

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

  def members
    self.class.members
  end

  def initialize(datetime)
    @datetime = datetime
  end

  def method_missing(sym, *args, &blk)
    @datetime.send(sym, *args, &blk)
  end
end
