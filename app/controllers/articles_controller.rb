# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :search_data

  def index
    if tag_search?
      redirect_to tags_path(collection: @collection, tag: tag_param)
    else
      @tags = @collection.owned_tags.sort_by(&:name)
      @articles = SearchResult.new(query: @query)
        .articles
        .paginate(page: params[:page], per_page: SearchResult::PAGE_SIZE)
    end
  end

  private

  def search_data
    @query = params[:query] || ''
  end

  def tag_search?
    @query.strip[0] == '#'
  end

  def tag_param
    @query.slice(1, @query.length - 1)
  end
end
