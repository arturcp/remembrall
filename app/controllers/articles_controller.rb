# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :search_data

  def index
    @articles = articles_list
      .paginate(page: params[:page], per_page: SearchResult::PAGE_SIZE)
  end

  def search
    if @query.present?
      redirect_to articles_path(search_type: @search_type, query: @query)
    else
      redirect_to root_path
    end
  end

  private

  def search_data
    @search_type = params[:search_type] || SearchType::KEYWORD
    @query = params[:query] || ''
  end

  def articles_list
    return Article.all unless @query.present?

    SearchResult.new(search_type: @search_type, query: @query).articles
  end
end
