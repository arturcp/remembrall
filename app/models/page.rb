# frozen_string_literal: true

# Public: Wrapper for the client that scrapes the webpage to extract information,
# such as title, description and images.
class Page
  # TODO: this hack prevents the code to break when the page defective images
  # set on the og:image metatag. There are already two opened pull requests on
  # other gems that can prevent this problem:
  #
  # * link_thumbnailer: hhttps://github.com/gottfrois/link_thumbnailer/pull/106
  # * image_info: https://github.com/gottfrois/image_info/pull/5
  #
  # An example of a breaking page is
  # * https://codeascraft.com/2016/10/19/being-an-effective-ally-to-women-and-non-binary-people/
  #
  # While none of them are merged, keep this rescue block to prevent unexpected
  # behavior
  def self.read(url)
    LinkThumbnailer.generate(url)
  rescue
    LinkThumbnailer.generate(url, attributes: [:title, :description, :favicon])
  end
end
