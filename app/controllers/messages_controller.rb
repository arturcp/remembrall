# frozen_string_literal: true

class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    Article.from_message(
      message: Message.new(params['message']['event']['text']),
      user_id: params['message']['event']['user']
    )

    render text: params['challenge']
  end

  private

  def slack_params
    params.permit(:message).permit(:event).permit(:text, :user)
  end
end
