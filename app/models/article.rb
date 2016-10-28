# frozen_string_literal: true

class Article < ActiveRecord::Base
  acts_as_taggable

  def initialize(url:, author_name:, title:, description:, image_url:, favicon:)
    @url = url
    @author_name = author_name
    @title = title
    @description = description
    @image_url = image_url
  end

  def self.build(author_name, url)
    page_content = LinkThumbnailer.generate(url)

    if page_content
      Article.create!(
        url: url,
        author_name: author_name,
        title: page_content.title,
        description: page_content.description,
        image_url: page_content.images.first.src.to_s,
        favicon: page_content.favicon
      )
    end
  end
end
