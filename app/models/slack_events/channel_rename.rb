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
        tag = @collection.owned_tags.find_by(name: channel.name)

        channel.update(name: channel_name)
        tag&.update(name: channel_name)
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
  end
end
