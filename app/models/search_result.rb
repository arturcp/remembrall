# frozen_string_literal: true

class SearchResult
  PAGE_SIZE = 9

  def initialize(query: '')
    @query = query.downcase
  end

  def articles
    if @query.present?
      Article.with_query(@query).order(created_at: :desc)
    else
      Article.all.order(created_at: :desc) unless @query.present?
    end
  end
end
