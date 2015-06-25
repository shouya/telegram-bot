class TelegramBot
  class PollListener
    def initialize(client, interval)
      @client    = client
      @interval  = interval
      @offset_id = nil
    end

    def message_received(msg)
      @client.append_history(msg)
      @client.handle(msg)
    end

    def start!
      loop do
        get_updates
        sleep @interval
      end
    end

    def get_updates
      updates = @client.get_updates(@offset_id, 50)
      updates.each do |update|
        @offset_id = update.id
        message_received(update.message)
      end
    end
  end
end
