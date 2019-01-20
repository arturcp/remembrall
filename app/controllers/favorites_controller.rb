# frozen_string_literal: true

class FavoritesController < ApplicationController
  def index
    @tags = Tag.all.sort_by(&:name)
    @articles = current_user.articles.paginate(page: params[:page],
      per_page: SearchResult::PAGE_SIZE)
  end

  def create
    article = Article.find(permitted_params[:article_id])

    if current_user.favorited?(article)
      current_user.articles.delete(article)
    else
      current_user.articles << article
    end

    current_user.save!

    head :ok
  end

  private

  def permitted_params
    params.permit(:article_id, :user_id)
  end
end
