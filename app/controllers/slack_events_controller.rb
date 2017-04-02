# frozen_string_literal: true

class SlackEventsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  SLACK_VERIFICATION_MODE = false

  # Public: Slack will dispatch events that will be capture by this action. This
  # controller is listening to these types of events:
  #
  # * New message: triggered when someone sends a new message in a channel that
  #   contains the bot. Check the file `docs/message_new.json` to get an example
  #   of the params sent by slack.
  #
  # * Message deleted: triggered when someone deletes a message from a channel
  #   that contains the bot. Check the file `docs/message_delete.json` to get an
  #   example of the params sent by slack.
  #
  # * User profile changed: triggered when a user of a team that uses the app
  #   changes any information in his/her profile. Check the file
  #   `docs/profile_change.json` to get an example of the params sent by slack.
  #
  # * Channel changed: triggered when someone renames a channel. Check the file
  #   `docs/channel_rename.json` to get an example of the params sent by slack.
  #
  # TIP: When you change the url on slack you must return the challenge param to prove
  # you own the url. To make it easier, just change the `SLACK_VERIFICATION_MODE`
  # constant to true, verify the url and turn it back to false to make remembrall
  # salve the links.
  #
  # Returns nothing.
  def create
    if SLACK_VERIFICATION_MODE
      render text: params['challenge']
    else
      execute_event
    end
  end

  private

  def execute_event
    SlackEvent.execute(collection, params.to_unsafe_hash.deep_symbolize_keys)

    head :ok
  end

  def collection
    @collection ||= Collection.find_by(team_id: params['team_id'])
  end
end
