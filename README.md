# TelegramBotRuby

[telegram api doc](https://core.telegram.org/bots/api)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'telegram_bot_ruby'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install telegram_bot_ruby
```

## Quick start

### Set up client

```ruby
require 'telegram_bot'

bot = TelegramBot.new(token: <token>)

bot.listen(method: :webhook, url: '/meow/meow')  # not implemented yet
# or
bot.listen(method: :poll, interval: 1)
```

### Set up update listeners

```ruby
bot.on :command, 'ping' do  # /ping
  reply 'pong'
end

bot.on :command, 'plus' do |num1, num2|  # /plus 1 2
  reply (num1.to_i + num2.to_i).to_s
end

bot.on :text 'ping' do     # plain 'ping'
  send_message 'pong'
end

# with block: false, message will keep passing through other listeners
bot.on :text, /(\d+)\+(\d+)\=\?/, block: false do |n1, n2|
  send_chat_action :typing
  send_message (n1.to_i + n2.to_i).to_s
end

# a simple history logger
bot.on :anything do |msg|
  Database.save [msg.from.username, msg.text] if !msg.text.empty?
end
```

### Start && Stop

```ruby
# register service at telegram or start long polling
trap(:INT) {
    bot.stop!
}
bot.start!
```

## Documentation

### Matchers

**anything/fallback matcher**

```ruby
on :anything
on :fallback
```

**text matcher**

```ruby
# match when message.type == :text
on :text do |txt|
end

# arguments are given by `MatchData#to_a`
on :text, /reply me with (.*)/ do |matched_text, reply_txt|
    send_message reply_txt
end
```

**command matcher**

```ruby
on :command, :ping do
    reply 'pong'
end

# handling requests like `/plus 1 2`
on :command :plus do |*args|
    reply args.map(&:to_i).sum.to_s
end

# or handle all commands
on :command do |cmd, *args|
    case cmd
    when 'echo'
        reply args.join(' ')
    when 'rand'
        reply rand.to_s
    else
        reply "unknown command #{cmd}"
    end
end
```

### Telegram Types

Check the classes that include this module:

http://www.rubydoc.info/gems/telegram_bot_ruby/TelegramBot/AutoFromMethods

### Bot methods

```
# msg: message object, or message id
# to: chat/user object or chat/user id
TelegramBot#forward_message(msg, to, from = nil)

TelegramBot#get_me => User

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
# chat: {chat,user} {object,id}
# action: CHAT_ACTIONS.sample
TelegramBot#send_chat_action(chat, action)


# chat: {chat,user} {object,id}
# text: text content of the message
# disable_web_page_preview: see Telegram doc
# reply_to: message object or id
# reply_markup: a keyboard markup, see example below
send_message(chat,
             text,
             disable_web_page_preview: nil,
             reply_to: nil,
             reply_markup: nil)


# example keyboard markup
markup = {
    keyboard: [
        ["1", "2"],
        ["3", "4", "5"],
        ["6"]
    ],
    selective: false
}
```

### Shorthand methods

shorthand methods can be used within the handler block, with the
received message as context. [rubydoc.info](http://www.rubydoc.info/gems/telegram_bot_ruby/TelegramBot/ShorthandMethods)

```ruby
reply(text, *args)
send_message(text, *args)
forward_message(to, *args)
send_chat_action(action, *args)
```

### Handler context variables/methods

Other than the shorthand above, within the handler block, these
contextual variable are accessible:

```
bot            # the current TelegramBot instance
bot.history    # request histories :: [Message]
bot.start!     # start polling
bot.stop!      # quit the bot

message        # the message just received
message.<attr> # message attributes
matcher        # current matcher object
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shouya/telegram-bot.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
