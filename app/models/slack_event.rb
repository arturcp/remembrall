# frozen_string_literal: true

class SlackEvent
  def self.execute(collection, params)
    event_class = "SlackEvents::#{params[:event][:type].classify}".safe_constantize

    event_class&.new(collection, params)&.execute
  end
end
