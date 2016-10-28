# frozen_string_literal: true

class Message
  URL_REGEX = /<(https?:\/\/(?:www.|(?!www))[^\s.]+.[^\s]{2,}|www.[^\s]+.[^\s]{2,})>/

  def initialize(text = '')
    @text = text
  end

  def urls
    @urls ||= @text.scan(URL_REGEX).flatten
  end
end
