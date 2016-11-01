# frozen_string_literal: true

class SearchResult
  PAGE_SIZE = 10

  def initialize(query: '', search_type: SearchType::KEYWORD)
    @query = query.downcase
    @search_type = search_type
  end

  def articles
    if @query.present?
      send("search_by_#{@search_type}", @query).order(created_at: :desc)
    else
      Article.all.order(created_at: :desc) unless @query.present?
    end
  end

  private

  def search_by_keyword(query)
    Article.with_query(query)
  end

  def search_by_author(query)
    Article.joins(:user)
      .where('lower(users.name) like :name', name: "%#{@query}%")
  end

  def search_by_tag(query)
    Article.tagged_with(query)
  end
end
