# frozen_string_literal: true

class URL
  REGEX = /<(https?:\/\/(?:www.|(?!www))[^\s.]+.[^\s]{2,}|www.[^\s]+.[^\s]{2,})>/
  BLACK_LIST = [
    'hangouts.google.com',
    'youse-remembrall.herokuapp.com',
    'github.com',
    'cxdigital.atlassian.net',
    'docs.google.com',
    'drive.google.com',
    'sentry.io'
  ].freeze

  attr_reader :url

  def initialize(url)
    @url = url
  end

  def valid?
    !black_listed?
  end

  private

  def black_listed?
    BLACK_LIST.reduce(false) do |status, item|
      status ||= url.include?(item)
    end
  end
end
