# frozen_string_literal: true

class Article < ActiveRecord::Base
  acts_as_indexed fields: [:title, :description]

  belongs_to :user

  def self.build(slack_user_id, slack_user_name, url)
    page_content = LinkThumbnailer.generate(url)

    if page_content
      user = User.find_by(slack_id: slack_user_id)

      Article.new.tap do |article|
        article.user = user if user.present?

        article.url = url
        article.title = page_content.title
        article.description = page_content.description
        article.favicon = page_content.favicon

        if page_content.images.first
          article.image_url = page_content.images.first.src.to_s
        else
          article.image_url = 'http://media1.santabanta.com/full1/Creative/Abstract/abstract-749a.jpg'
        end
      end.save!
    end
  end

  def author
    user || User.default
  end
end
