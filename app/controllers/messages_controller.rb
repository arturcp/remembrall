# frozen_string_literal: true

class MessagesController < ApplicationController
  def create

  end

  private

  def slack_params
    params.permit(:token, :team_id, :team_domain, :channel_id, :channel_name,
      :timestamp, :user_id, :user_name, :text, :trigger_word)
  end
end
