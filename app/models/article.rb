# frozen_string_literal: true

class Article < ActiveRecord::Base
  acts_as_taggable
  acts_as_indexed fields: [:title, :description]

  def self.build(author_name, url)
    page_content = LinkThumbnailer.generate(url)

    if page_content
      Article.new.tap do |article|
        article.url = url
        article.author_name = author_name
        article.title = page_content.title
        article.description = page_content.description
        article.image_url = page_content.images.first.src.to_s
        article.favicon = page_content.favicon
      end.save!
    end
  end
end
