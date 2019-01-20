# frozen_string_literal: true

# Public: Wrapper for the client that scrapes the webpage to extract information,
# such as title, description and images.
class Page
  def self.read(url)
    LinkThumbnailer.generate(url)
  end
end
