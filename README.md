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

## Usage

### Set up client

```ruby
require 'telegram_bot_ruby'

bot = TelegramBot.new(token: <token>)

bot.listen(method: :webhook, url: '/meow/meow')  # not implemented yet
# or
bot.listen(method: :poll, interval: 1)
```

### Set up update listeners

```ruby
bot.on_command 'ping' do  # /ping
  reply 'pong'
end

bot.on_command 'plus' do |num1, num2|  # /plus 1 2
  reply (num1.to_i + num2.to_i).to_s
end

bot.on_text 'ping' do     # plain 'ping'
  send_message 'pong'
end

# with block: false, message will keep passing through other listeners
bot.on_text /(\d+)\+(\d+)\=\?/, block: false do |n1, n2|
  send_chat_action :typing
  send_message (n1.to_i + n2.to_i).to_s
end

# a simple history logger
bot.anything do |msg|
  Database.save [msg.from.username, msg.text] if !msg.text.empty?
end
```

### Start && Stop

```ruby
# register service at telegram or start long polling
bot.start!
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shouya/telegram-bot.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
