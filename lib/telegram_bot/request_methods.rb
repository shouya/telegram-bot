class TelegramBot
  module RequestMethods
    def get_updates(offset: nil, limit: nil, timeout: nil)
      params = {
        offset:  offset,
        limit:   limit,
        timouet: timeout
      }.reject {|_,v| v.nil?}

      request(:get_updates, params).map do |update|
        Update.from(update)
      end
    end

    def get_me
      User.from(request(:get_me, {}))
    end

    def send_message(chat, text,
                     disable_web_page_preview: nil,
                     reply_to: nil,
                     reply_markup: nil)
      reply_to = Message.from(reply_to)
      params = {
        chat_id: Chat.from(chat).id,
        text: text,
        disable_web_page_preview: disable_web_page_preview,
        reply_to_message_id: reply_to && reply_to.id,
        reply_markup: reply_markup ? reply_markup.to_json : nil
      }.reject {|_,v| v.nil?}

      Message.from(request(:send_message, params))
    end

    def forward_message(msg, to, from = nil)
      from_chat = from.nil? ? msg.chat : Chat.from(from)

      params = {
        chat_id: Chat.from(chat).id,
        from_chat_id: from_chat.id,
        message_id: Message.from(msg).id
      }

      Message.from(request(:forward_message, params))
    end


    CHAT_ACTIONS = [
      :typing,
      :upload_photo,
      :record_video,
      :update_video,
      :record_audio,
      :upload_audio,
      :upload_document,
      :find_location
    ]

    def send_chat_action(chat, action)
      unless CHAT_ACTIONS.include?(action.intern)
        warn "invalid chat action #{action}, available actions are" +
             " #{CHAT_ACTIONS.join(', ')}."
        action = CHAT_ACTIONS.first
      end

      params = {
        chat_id: Chat.from(chat).id,
        action: action.to_s
      }

      request(:send_chat_action, params)
      nil
    end

    METHODS = [
      :get_me,
      :send_message,
      :forward_message,
      :send_photo,
      :send_document,
      :send_sticker,
      :send_video,
      :send_location,
      :send_chat_action,
      :get_user_profile_photos,
      :get_updates,
      :set_webhook
    ]

    private

    def todo(*args, &block)
      defn_at = self.method(__callee__).source_location
      warn "#{defn_at[0]}:<#{__callee__}>: not implemented"
    end

    public

    METHODS.each do |method|
      is_defined = self.instance_methods(false).include?(method)
      unless is_defined
        alias_method method, :todo
      end

      alias_method "#{method}_raw", method
    end

  end
end
