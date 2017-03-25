# frozen_string_literal: true

require 'net/http'
require 'uri'

class SlackAPI
  OAUTH_ACCESS_URL = 'https://slack.com/api/oauth.access'
  USERS_INFO_URL = 'https://slack.com/api/users.info'
  CHANNEL_INFO_URL = 'https://slack.com/api/channels.info'

  # Public: Request an oauth token to allow future requests using oAuth2.
  #
  # code - it is provided by slack api, automatically included in the return url
  #        configured in the slack app.
  #
  # An example of a valid response of the method can be found at `docs/oauth_access.json`
  #
  # It will post to https://slack.com/api/oauth.access
  #
  # Returns a JSON.
  def self.request_token(code)
    params = {
      code: code,
      client_id: ENV.fetch('SLACK_CLIENT_ID'),
      client_secret: ENV.fetch('SLACK_CLIENT_SECRET')
    }

    post(OAUTH_ACCESS_URL, params)
  end

  # Public: fetches info about a user.
  #
  # An example of a valid response of the method can be found at `docs/user_info.json`
  #
  # The token must have the users:read permission.
  # It will post to https://slack.com/api/users.info
  #
  # Returns a JSON.
  def self.user_info(token, user_id)
    post(USERS_INFO_URL, { token: token, user: user_id })
  end

  def self.channel_info(token, channel_id)
    post(CHANNEL_INFO_URL, { token: token, channel: channel_id })
  end

  def self.post(url, params)
    uri = URI.parse(url)
    response = Net::HTTP.post_form(uri, params)

    JSON.parse(response.body).deep_symbolize_keys
  end

  private_class_method :post
end
