# frozen_string_literal: true

class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    message = Message.new(slack_params[:text])

    message.urls.each do |url|
      Article.build(slack_params[:user_name], url)
    end

    head :ok
  end

  private

  def slack_params
    params.permit(:token, :team_id, :team_domain, :channel_id, :channel_name,
      :timestamp, :user_id, :user_name, :text, :trigger_word)
  end
end
