# frozen_string_literal: true

class Article < ApplicationRecord
  DEFAULT_IMAGE_URL = 'http://media1.santabanta.com/full1/Creative/Abstract/abstract-749a.jpg'

  acts_as_indexed fields: [:title, :description, :author_name]
  acts_as_taggable

  validates :url, uniqueness: true
  belongs_to :user
  belongs_to :collection
  belongs_to :channel

  has_many :favorites
  has_many :users, through: :favorites

  def author
    user || User.default
  end

  def author_name
    author.name
  end
end
