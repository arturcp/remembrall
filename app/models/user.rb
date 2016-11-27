# frozen_string_literal: true

class User < ActiveRecord::Base
  DEFAULT_NAME = 'Anônimo'
  DEFAULT_AVATAR = 'https://mytruesense.files.wordpress.com/2013/07/question-mark.png'

  def self.default
    new(name: DEFAULT_NAME, avatar_url: DEFAULT_AVATAR)
  end

  def self.from_omniauth(auth)
    omniauth_user = auth.extra.raw_info.user_info.user

    where(slack_id: omniauth_user.id).first_or_initialize.tap do |user|
      user.slack_id = omniauth_user.id
      user.name = omniauth_user.name
      user.avatar_url = omniauth_user.profile.image_72
      user.save!
    end
  end
end
