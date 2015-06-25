class Chat < Struct.new(:id)
  def self.from(id)
    case id
    when Integer
      Chat.new(id)
    when GroupChat, User
      id
    when Hash
      if id.has_key? 'title'
        GroupChat.from(id)
      elsif id.has_key? 'first_name'
        User.from(id)
      else
        Chat.from(id['id'])
      end
    else
      warn 'unknown chat'
    end
  end
end
