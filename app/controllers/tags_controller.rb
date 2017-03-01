class TagsController < ApplicationController
  def index
    @tags = Tag.all.sort_by(&:name)
    @tag = params[:tag]
    @articles = Article.tagged_with(@tag)
      .paginate(page: params[:page], per_page: SearchResult::PAGE_SIZE)
  end
end
