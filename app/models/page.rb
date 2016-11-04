# frozen_string_literal: true

# Public: Wrapper for the client that scrapes the webpage to extract information,
# such as title, description and images.
class Page
  # TODO: this hack prevents the code to break when the page has no images. The
  # right solution is to open a PR on the link_thumbnailer gem to prevent the code
  # to break in this scenario.
  #
  # An example of a breaking page is
  # * https://codeascraft.com/2016/10/19/being-an-effective-ally-to-women-and-non-binary-people/
  def self.read(url)
    LinkThumbnailer.generate(url)
  rescue
    LinkThumbnailer.generate(url, attributes: [:title, :description, :favicon])
  end
end
