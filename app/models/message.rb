# frozen_string_literal: true

class Message
  def initialize(text = '')
    @text = text
  end

  def urls
    @urls ||= @text.scan(URL::REGEX).flatten
  end
end
