# frozen_string_literal: true

class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  SLACK_VERIFICATION_MODE = false

  # Public: Slack will dispatch events that will be capture by this action. This
  # controller is listening to these types of events:
  #
  # * New message: triggered when someone sends a new message in a channel that contains the bot.
  # * Message deleted: trigger when someone deletes a message from a channel that contains the bot.
  # * User profile changed: when any user of a team that uses the app changes any information in his/her profile.
  #
  # For examples of the hash the slack sends for each type of event, check the
  # json files at `docs/message_<EVENT_TYPE>.json`
  #
  # When you change the url on slack you must return the challenge param to prove
  # you own the url. To make it easier, just change the `SLACK_VERIFICATION_MODE`
  # constant to true, verify the url and turn it back to false to make remembrall
  # salve the links.
  def create
    if SLACK_VERIFICATION_MODE
      render text: params['challenge']
    else
      crete_message
    end
  end

  private

  def crete_message
    event = SlackEvent.new(safe_params)
    message = Message.new(event.message)

    if event.new_message? && message.has_urls?
      create_user(event) if event.new_user?

      Article.from_message(
        message: message,
        user_id: event.user_id,
        collection: collection
      )
    elsif event.profile_changed?
      update_user(event)
    end

    head :ok
  end

  def collection
    @collection ||= Collection.find_by(team_id: params['team_id'])
  end

  def safe_params
    params.permit(
      :challenge,
      event: [
        :type,
        user: [
          :id,
          :deleted,
          :name,
          profile: [:image_72]
        ]
      ],
      message: [
        event: [:text, :user, :deleted_ts, :team_id, :type]
      ]
    )
  end

  def create_user(event)
    data = SlackAPI.user_info(collection.bot_access_token, event.user_id)
    save_user(event, data)
  end

  def update_user(event)
    save_user(event, safe_params.to_unsafe_hash.deep_symbolize_keys[:event])
  end

  def save_user(event, params)
    User.save_profile(
      collection: collection,
      id: event.user_id,
      name: params[:user][:name],
      avatar: params[:user][:profile][:image_72]
    )
  end
end
