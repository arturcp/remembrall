# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :search_data
  before_action :fetch_collection

  def index
    # TODO: fetch tags for the collection
    @tags = Tag.all.sort_by(&:name)
    @articles = SearchResult.new(query: @query)
      .articles
      .paginate(page: params[:page], per_page: SearchResult::PAGE_SIZE)
  end

  def search
    if @query.present?
      redirect_to articles_path(collection: @collection, query: @query)
    else
      redirect_to root_path
    end
  end

  private

  def search_data
    @query = params[:query] || ''
  end

  def fetch_collection
    @collection = Collection.friendly.find(params[:collection])
  end
end
