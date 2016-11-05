# frozen_string_literal: true

class User < ActiveRecord::Base
  DEFAULT_NAME = 'Anônimo'
  DEFAULT_AVATAR = 'http://4.bp.blogspot.com/-F1BbkGLis3Y/UaSOQmRxghI/AAAAAAAAAbY/rqWHvzeJ3C4/s72-c/Nevillelongbottom.jpg'

  def self.default
    new(name: DEFAULT_NAME, avatar_url: DEFAULT_AVATAR)
  end
end
