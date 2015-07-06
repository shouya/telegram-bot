require_relative 'objects'
require 'forwardable'

class TelegramBot::Message <
      Struct.new(:id,
                 :from,
                 :date,
                 :chat,
                 :forward_from,
                 :forward_date,
                 :reply_to_message,
                 :text,
                 :audio,
                 :document,
                 :photo,
                 :sticker,
                 :video,
                 :contact,
                 :location,
                 :new_chat_participant,
                 :left_chat_participant,
                 :new_chat_title,
                 :new_chat_photo,
                 :delete_chat_photo,
                 :group_chat_created)

  include TelegramBot::AutoFromMethods

  def self.hash_key_aliases
    {
      :id => :message_id,
    }
  end

  def self.extra_types
    {
      from:                  TelegramBot::User,
      chat:                  TelegramBot::Chat,
      forward_from:          TelegramBot::User,
      forward_date:          TelegramBot::Date,
      reply_to_message:      TelegramBot::Message,
      audio:                 TelegramBot::Audio,
      document:              TelegramBot::Document,
      photo: [               TelegramBot::PhotoSize],
      sticker:               TelegramBot::Sticker,
      video:                 TelegramBot::Video,
      contact:               TelegramBot::Contact,
      location:              TelegramBot::Location,
      new_chat_participant:  TelegramBot::User,
      left_chat_participant: TelegramBot::User
    }
  end

  def type
    case
    when text                  then :text
    when photo                 then :photo
    when audio                 then :audio
    when document              then :document
    when sticker               then :sticker
    when video                 then :video
    when contact               then :contact
    when location              then :location
    when new_chat_participant  then :member_entered
    when left_chat_participant then :member_left
    when new_chat_title        then :chat_title_updatd
    when new_chat_photo        then :chat_photo_updated
    when delete_chat_photo     then :chat_photo_deleted
    when group_chat_created    then :group_chat_created
    end
  end

  def is_forward?
    !!forward_from
  end

  def is_reply?
    !!reply_to_message
  end
end
