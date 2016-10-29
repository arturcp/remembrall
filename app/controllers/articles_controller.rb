# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @word = search_params[:query]
    @search_type = search_params[:search_type] || SearchType::KEYWORD
    @articles = Article.all
  end

  private

  def search_params
    @search_params ||= params.permit(
      :query,
      :search_type
    )
  end
end
