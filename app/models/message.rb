# frozen_string_literal: true

class Message
  TAG_REGEX = /(?:\s|\A)#(\S+)/

  def initialize(text)
    @text = text || ''
  end

  def urls
    @urls ||= @text.scan(URL::REGEX).flatten
  end

  def hashtags
    @hashtags ||= @text.scan(TAG_REGEX).flatten
  end

  def has_urls?
    urls.present?
  end
end
