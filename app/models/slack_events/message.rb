# frozen_string_literal: true

module SlackEvents
  class Message
    TAG_REGEX = /(?:\s|\A)#(\S+)/
    URL_REGEX = /<([^>]+)>/

    def initialize(collection, params)
      @collection = collection
      @params = params
      @event = params.dig(:slack_event, :event)
    end

    def execute
      return unless valid?

      save_user

      ArticleService.new(channel, user_id).article_from_message(self)
    end

    def urls
      @urls ||= message.scan(URL_REGEX).flatten
    end

    def hashtags
      @hashtags ||= message.scan(TAG_REGEX).flatten
    end

    private

    attr_reader :collection, :event, :params

    def valid?
      !message_deleted? && urls.present?
    end

    def message
      @message ||= event.fetch(:text, '')
    end

    def user_id
      @user_id ||= event[:user]
    end

    def message_deleted?
      event && event[:subtype] == 'message_deleted'
    end

    def save_user
      user = SlackEvents::UserChange.new(collection, params)
      user.execute if user.new_user?
    end

    def channel
      @channel ||= begin
        channel_id = params.dig(:event, :channel)
        channel = Channel.find_or_initialize_by(slack_channel_id: channel_id, collection_id: collection.id)

        if channel.new_record?
          data = SlackAPI.channel_info(collection.bot_access_token, channel_id)
          channel.name = data.dig(:channel, :name)
          channel.save
        end

        channel
      end
    end
  end
end
