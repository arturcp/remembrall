class User < ActiveRecord::Base
  def self.default
    avatar_url = 'http://4.bp.blogspot.com/-F1BbkGLis3Y/UaSOQmRxghI/AAAAAAAAAbY/rqWHvzeJ3C4/s72-c/Nevillelongbottom.jpg'

    self.new(name: 'Remembrall', avatar_url: avatar_url)
  end
end
