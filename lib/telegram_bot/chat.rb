class Chat < Struct.new(:id)
  def self.from(id)
    case id
    when Integer
      Chat.new(id)
    when String
      # ???
    when GroupChat, User
      id
    end
  end
end
