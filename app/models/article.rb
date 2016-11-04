# frozen_string_literal: true

class Article < ActiveRecord::Base
  acts_as_indexed fields: [:title, :description]

  belongs_to :user

  def self.build(slack_user_id, slack_user_name, url)
    page_content = fetch_page_content(url)

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

  # TODO: this hack prevents the code to break when the page has no images. The
  # right solution is to open a PR on the link_thumbnailer gem to prevent the code
  # to break in this scenario.
  #
  # An example of a breaking page is
  # * https://codeascraft.com/2016/10/19/being-an-effective-ally-to-women-and-non-binary-people/
  def self.fetch_page_content(url)
    LinkThumbnailer.generate(url)
  rescue
    LinkThumbnailer.generate(url, attributes: [:title, :description, :favicon])
  end
end
