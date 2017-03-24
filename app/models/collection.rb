# frozen_string_literal: true

class Collection < ActiveRecord::Base
  extend FriendlyId

  has_many :articles
  has_many :black_list_urls

  friendly_id :name, use: :slugged
  acts_as_tagger

  def self.create_from_oauth_response(response)
    team = find_by(team_id: response[:team_id])
    return team if team.present?

    create!(
      name: response[:team_name],
      team_id: response[:team_id],
      bot_user_id: response[:bot][:bot_user_id],
      bot_access_token: response[:bot][:bot_access_token]
    )
  end
end
