class TagsController < ApplicationController
  def index
    @tags = @collection.owned_tags.sort_by(&:name)
    @tag = params[:tag]
    @query = "##{@tag}"
    @articles = Article.tagged_with(@tag, on: :tags, owned_by: @collection)
      .paginate(page: params[:page], per_page: SearchResult::PAGE_SIZE)
  end
end
