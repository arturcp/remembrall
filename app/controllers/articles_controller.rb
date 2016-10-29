# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :search_type, :search_word

  def index
    @articles = Article.all.limit(SearchResult::PAGE_SIZE)
  end

  def search
    @articles = SearchResult.new(
      query: "%#{@word}%",
      search_type: @search_type
    ).articles
  end

  private

  def search_params
    @search_params ||= params.permit(
      :query,
      :search_type
    )
  end

  def search_type
    @search_type = search_params[:search_type] || SearchType::KEYWORD
  end

  def search_word
    @word = search_params[:query]
  end
end
