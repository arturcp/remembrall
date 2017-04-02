# frozen_string_literal: true

# Public: Builds an `Article` based on the message sent by slack.
class ArticleService
  attr_reader :channel, :user_id

  def initialize(channel, user_id)
    @channel = channel
    @user_id = user_id
  end

  def article_from_message(message)
    message.urls.map do |slack_url|
      site = URL.from_slack(slack_url)

      if site.valid?
        build(site.url, message.hashtags)
      end
    end.compact
  end

  private

  def build(url, hashtags = [])
    collection = channel.collection

    unless Article.exists?(collection: collection, url: url)
      content = Page.read(url)
      user = User.find_by(slack_id: user_id)

      article = Article.new(
        collection: collection,
        user: user,
        url: url,
        title: content.title,
        description: content.description,
        favicon: content.favicon,
        image_url: content.images.first&.src || Article::DEFAULT_IMAGE_URL,
        channel_id: channel.id
      )

      article.save
      collection.tag(article, with: "#{channel.name}, #{hashtags.join(', ')}", on: :tags)

      article
    end
  rescue => e
    Rails.logger.debug e
  end
end
