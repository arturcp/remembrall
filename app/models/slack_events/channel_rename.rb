# frozen_string_literal: true

module SlackEvents
  class ChannelRename
    def initialize(collection, params)
      @collection = collection
      @event = params[:event]
    end

    def execute
      channel = Channel.find_by(slack_channel_id: slack_channel_id)
      return unless channel

      tag = @collection.owned_tags.find_by(name: channel.name)
      tag.update(name: channel_name) if tag

      channel.update(name: channel_name)
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
