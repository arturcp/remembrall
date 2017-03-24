# frozen_string_literal: true

class Article < ApplicationRecord
  acts_as_indexed fields: [:title, :description, :author_name]
  acts_as_taggable

  validates :url, uniqueness: true
  belongs_to :user
  belongs_to :collection

  has_many :favorites
  has_many :users, through: :favorites

  DEFAULT_IMAGE_URL = 'http://media1.santabanta.com/full1/Creative/Abstract/abstract-749a.jpg'

  def self.build(collection, slack_user_id, url, hashtags = [])
    return unless URL.new(url).valid?

    content = Page.read(url)
    user = User.find_by(slack_id: slack_user_id)

    article = create(
      collection: collection,
      user: user,
      url: url,
      title: content.title,
      description: content.description,
      favicon: content.favicon,
      image_url: content.images.first&.src || DEFAULT_IMAGE_URL,
      tag_list: hashtags
    )

    collection.tag(article, with: hashtags, on: :tags)

    article
  rescue => e
    logger.debug e
  end

  def self.from_message(message:, user_id:, collection:)
    message.urls.map do |url|
      valid_url = url.split('|').first
      next if valid_url[0] == '@'

      build(collection, user_id, valid_url, message.hashtags)
    end.compact
  end

  def author
    user || User.default
  end

  def author_name
    author.name
  end
end
