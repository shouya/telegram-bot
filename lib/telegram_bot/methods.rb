module TelegramBot
  module Methods
    def get_update(offset: nil, limit: nil, timeout: nil)
      params = {
        offset:  offset,
        limit:   limit,
        timouet: timeout
      }.reject {|_,v| v.nil?}

      request(:get_update, params).map do |update|
        Update.parse(update)
      end
    end

    def get_me
      User.parse(request(:get_me, {}))
    end

    def send_message(chat, text,
                     disable_web_page_preview: nil,
                     reply_to: nil,
                     reply_markup: nil)
      params = {
        chat_id: Chat.from(chat).id,
        text: text,
        disable_web_page_preview: disable_web_page_preview,
        reply_to_message_id: Chat.from(reply_to).id
        # TODO:
        # reply_markup: reply_markup
      }.reject {|_,v| v.nil?}

      Message.parse(request(:send_message, params))
    end

    def forward_message(msg, to, from = nil)
      from_chat = from.nil? ? msg.chat : Chat.from(from)

      params = {
        chat_id: Chat.from(chat).id,
        from_chat_id: from_chat.id,
        message_id: Message.from(msg).id
      }

      Message.parse(request(:forward_message, params))
    end

    alias_method :send_photo, :todo
    alias_method :send_document, :todo
    alias_method :send_sticker, :todo


    private

    def todo
      defn_at = self.method(__callee__).source_location
      warn "#{defn_at[0]}:<#{__callee__}>: not implemented"
    end
  end
end
