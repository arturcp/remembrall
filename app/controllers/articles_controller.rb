# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :search_data

  def index
    @articles = SearchResult.new(search_type: @search_type).articles
  end

  def search
    @articles = SearchResult.new(query: "%#{@query}%",
      search_type: @search_type).articles
  end

  private

  def search_data
    @search_type = params[:search_type] || SearchType::KEYWORD
    @query = params[:query]
  end
end
