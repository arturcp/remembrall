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
        article.image_url = page_content.images.first.src.to_s
        article.favicon = page_content.favicon
      end.save!
    end
  end

  def author
    user || User.default
  end
end
