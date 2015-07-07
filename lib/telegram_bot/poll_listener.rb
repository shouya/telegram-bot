class TelegramBot
  class PollListener
    def initialize(client, interval)
      @client    = client
      @interval  = interval
      @offset_id = nil
      @terminate_signal = false
    end

    def message_received(msg)
      @client.append_history(msg)
      @client.handle(msg)
    end

    def stop!
      @terminate_signal = true
    end

    def start!
      @terminate_signal = false

      loop do
        get_updates.each do |update|
          message_received(update.message)
          @offset_id = update.id + 1

          if @terminate_signal
            save_offset
            break
          end
        end

        break if @terminate_signal

        sleep @interval
      end
    end

    def get_updates
      updates = @client.get_updates(offset: @offset_id,
                                    limit: 50)
      updates
    end

    def save_offset
      @client.get_updates(limit: 0, offset: @offset_id)
    end
  end
end
