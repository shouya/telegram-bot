class Message < Struct(:id, :from, :date, :chat)
  attr_accessor :params

  def initialize(id, from, date, chat, **params)
    super(id, from, date, chat)
    @params = params
  end
end
