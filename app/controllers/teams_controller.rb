# frozen_string_literal: true

class TeamsController < ApplicationController
  def connect
    collection = create_team(params['code'])

    if collection
      redirect_to articles_path(collection)
    else
      render text: 'Não foi possível conectar com o Remembrall'
    end
  end

  private

  def create_team(code)
    return unless code.present?

    response = SlackAPI.request_token(code)
    Collection.create_from_oauth_response(response)
  end
end
