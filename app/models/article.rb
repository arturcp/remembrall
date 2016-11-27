# frozen_string_literal: true

class Article < ActiveRecord::Base
  acts_as_indexed fields: [:title, :description, :author_name]
  validates :url, uniqueness: true
  belongs_to :user

  DEFAULT_IMAGE_URL = 'http://media1.santabanta.com/full1/Creative/Abstract/abstract-749a.jpg'

  def self.build(slack_user_id, url)
    return unless URL.new(url).valid?

    content = Page.read(url)
    user = User.find_by(slack_id: slack_user_id)

    create(
      user: user,
      url: url,
      title: content.title,
      description: content.description,
      favicon: content.favicon,
      image_url: content.images.first&.src || DEFAULT_IMAGE_URL
    )
  end

  def self.fromMessage(message:, user_id:)
    message.urls.each do |url|
      build(user_id, url)
    end
  end

  def author
    user || User.default
  end

  def author_name
    author.name
  end
end
