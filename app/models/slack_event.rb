# frozen_string_literal: true

class SlackEvent
  attr_reader :message, :user_id

  MESSAGE_TYPE = 'message'
  PROFILE_CHANGE_TYPE = 'user_change'

  def initialize(params)
    @params = params.deep_symbolize_keys

    @message = params[:message][:event][:text]
    @user_id = extract_user_id
  end

  def new_message?
    params[:message][:event][:type] == MESSAGE_TYPE && !deleted_message?
  end

  def profile_changed?
    params[:event][:type] == PROFILE_CHANGE_TYPE &&
      !params[:event][:user][:deleted]
  end

  def deleted_message?
    params[:message][:event][:deleted_ts].present?
  end

  def new_user?
    user_id && !User.exists?(slack_id: user_id)
  end

  private

  attr_reader :params

  # Private: extract the user if from the params. It can be either on the
  # node `user`, as a string, or in `user[:id]`.
  def extract_user_id
    case @params[:event][:type]
    when 'user_change'
      @params[:event][:user][:id]
    when 'message'
      @params[:message][:event][:user]
    end
  end
end
