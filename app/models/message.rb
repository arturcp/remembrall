# frozen_string_literal: true

class Message
  LINK_REGEX = /(https?:\/\/(?:www.|(?!www))[^\s.]+.[^\s]{2,}|www.[^\s]+.[^\s]{2,})/

  def initialize(text = '')
    @text = text
  end

  def links
    @links ||= @text.scan(LINK_REGEX).flatten
  end
end
