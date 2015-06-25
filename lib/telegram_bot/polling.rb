module TelegramBot
  class Polling
    def initialize(client, interval)
      @client   = client
      @interval = interval
    end

    def message_received(msg)
      @client.handle(msg)
    end

    def start!
      offset = nil
      loop do
        updates = @client.get_update(offset, 50)
        updates.each do |update|
          offset = update.id
          @client.history << update.message
          message_received(update.message)
        end
        sleep interval
      end
    end
  end
end
