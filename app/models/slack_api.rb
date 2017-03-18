# frozen_string_literal: true

require 'net/http'
require 'uri'

class SlackAPI
  def self.request_token(code)
    uri = URI.parse('https://slack.com/api/oauth.access')
    params = {
      code: code,
      client_id: ENV.fetch('SLACK_CLIENT_ID'),
      client_secret: ENV.fetch('SLACK_CLIENT_SECRET')
    }
    response = Net::HTTP.post_form(uri, params)

    JSON.parse(response.body, symbolize_names: true)
  end
end
