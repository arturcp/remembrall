# frozen_string_literal: true

module SlackEvents
  class ChannelRename
    def initialize(collection, params)
      @collection = collection
      @event = params[:event]
    end

    def execute
      channel = Channel.find_by(slack_channel_id: slack_channel_id)

      if channel
        update_channel_name(channel, channel_name)
      end
    end

    private

    attr_reader :collection, :event

    def channel_name
      event[:channel][:name]
    end

    def slack_channel_id
      event[:channel][:id]
    end

    def update_channel_name(channel, name)
      channel.update(name: name)
    end
  end
end
