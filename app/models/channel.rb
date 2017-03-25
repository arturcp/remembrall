class Channel < ActiveRecord::Base
  belongs_to :collection
  has_many :articles
end
