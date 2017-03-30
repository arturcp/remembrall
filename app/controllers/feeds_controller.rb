# frozen_string_literal: true

class FeedsController < ApplicationController
  def index
    @articles = Article.where(collection: @collection)

    respond_to do |format|
      format.rss { render layout: false }
    end
  end
end
