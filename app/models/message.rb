# frozen_string_literal: true

class Message
  URL_REGEX = /<(https?:\/\/(?:www.|(?!www))[^\s.]+.[^\s]{2,}|www.[^\s]+.[^\s]{2,})>/
  BLACK_LIST = [
    'hangouts.google.com',
    'youse-remembrall.herokuapp.com',
    'github.com',
    'cxdigital.atlassian.net',
    'docs.google.com'
  ]

  def initialize(text = '')
    @text = text
  end

  def urls
    @urls ||= @text.scan(URL_REGEX).flatten
  end

  def self.valid_url?(url)
    !BLACK_LIST.reduce(false) do |status, item|
      status ||= url.include?(item)
    end
  end
end
