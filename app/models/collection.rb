# frozen_string_literal: true

class Collection < ActiveRecord::Base
  extend FriendlyId

  has_many :articles
  has_many :black_list_urls

  friendly_id :name, use: :slugged

  def self.create_from_oauth_response(response)
    return if exists?(team_id: response[:team_id])

    create!(
      name: response[:team_name],
      team_id: response[:team_id],
      slack_api_token: response[:access_token]
    )
  end
end
