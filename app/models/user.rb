# frozen_string_literal: true

class User < ApplicationRecord
  DEFAULT_NAME = 'Anônimo'
  DEFAULT_AVATAR = 'https://mytruesense.files.wordpress.com/2013/07/question-mark.png'

  has_many :favorites
  has_many :articles, through: :favorites

  def self.default
    new(name: DEFAULT_NAME, avatar_url: DEFAULT_AVATAR)
  end

  def self.from_omniauth(auth)
    omniauth_user = auth.extra.raw_info.user_info.user

    return unless omniauth_user

    where(slack_id: omniauth_user.id).first_or_initialize.tap do |user|
      user.slack_id = omniauth_user.id
      user.name = omniauth_user.name
      user.avatar_url = omniauth_user.profile.image_72
      user.save!
    end
  end

  def favorited?(article)
    articles.include?(article)
  end
end
