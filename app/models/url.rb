# frozen_string_literal: true

class URL
  REGEX = /<([^>]+)>/
  BLACK_LIST = [
    'hangouts.google.com',
    'youse-remembrall.herokuapp.com',
    'github.com',
    'cxdigital.atlassian.net',
    'docs.google.com',
    'drive.google.com',
    'sentry.io',
    'goo.gl/maps',
    'media.giphy.com',
    'meme.am',
    'youse.herokuapp',
    'youse.growbot.io',
    'giphy.com',
    'twitter.com',
    'slack.com/files',
    'ytimg.com'
  ].freeze

  attr_reader :url

  def initialize(url, black_list = BLACK_LIST)
    @url = url
    @black_list = black_list
  end

  def valid?
    !black_listed? && url[0] != '@'
  end

  def self.from_slack(slack_url)
    url = slack_url.split('|').first

    new(url)
  end

  private

  def black_listed?
    @black_list.reduce(false) do |status, item|
      status ||= url.include?(item)
    end
  end
end
